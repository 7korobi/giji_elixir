defmodule Giji.PotofController do
  use Giji.Web, :api_controller

  alias Giji.{Book, Potof, Phase}

  def create(conn, %{"potof" => params}) do
    %{"book_id" => book_id} = params
    book  = Repo.get!(Book, book_id)
    phase = Repo.get_by!(Phase, book_id: book_id, handle: "talk")

    %{changes: potof} = ins_potof = Potof.join(book, params)
#    %{changes: card}  = ins_card  = Card.join(potof, %{})

    res = Ecto.Multi.new
    |> Ecto.Multi.insert(:potof, ins_potof)
#    |> Ecto.Multi.insert(:card,  ins_card)
    |> Repo.transaction()

    case res do
      {:ok, %{potof: potof}} -> render_show  conn, potof
      {:error, at, c, _}     -> render_error conn, c, at
    end
  end

  def update(conn, %{"id" => id, "potof" => params}) do
    src = Repo.get!(Potof, id)
    dst = Potof.changeset(src, params)

    case Repo.update(dst) do
      {:ok, _} -> render_show  conn, src
      e        -> render_error conn, dst, e
    end
  end

  def delete(conn, %{"id" => id}) do
    src = Repo.get!(Potof, id)
    dst = Potof.bye(src)

    case Repo.update(dst) do
      {:ok, _} -> render_show  conn, src
      e        -> render_error conn, dst, e
    end
  end

  defp render_show(conn, potof) do
    conn
    |> render(potof: potof)
  end
end
