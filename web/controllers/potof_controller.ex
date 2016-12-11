defmodule Giji.PotofController do
  use Giji.Web, :api_controller

  alias Giji.{Book, Potof}

  def create(conn, %{"potof" => params}) do
    %{"book_id" => book_id} = params
    book = Repo.get!(Book, book_id)

    ins_potof = Potof.open(book, params)
    case Repo.insert(ins_potof) do
      {:ok, potof} -> render_show  conn, potof
      e            -> render_error conn, ins_potof, e
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
    dst = Potof.close(src)

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
