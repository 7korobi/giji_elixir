defmodule Giji.BookController do
  use Giji.Web, :api_controller

  alias Giji.{Book, Part, Section, Phase, Chat}

  @moduledoc """
    book api
  """

  def index(conn, _params) do
    books = Repo.all(from o in Book)
    conn
    |> render(books: books)
  end

  def show(conn, %{"id" => id}) do
    render_show conn, Repo.get!(Book, id)
  end

  # phase
  #  42-0-0 All   set   Caution Info        Talk Head Calc
  #  42-0-1 xxxx  think         Info Action Talk Head Calc
  #  42-0-2 P2    talk  Caution Info Action Talk Head Calc
  #  42-0-3 P3    buddy         Info Action Talk Head Calc
  def create(conn, %{"book" => params}) do
    style   = params["style"]
    rule    = params["rule"]
    caption = params["caption"]

    %{changes: book}  = ins_book    = Book.open(params)
    %{changes: part}  = ins_part    = Part.open(book,  0, "プロローグ")
    %{changes: phase} = ins_phase_0 = Phase.open(part, 0, "all",  "設定")
    %{changes: _}     = ins_phase_1 = Phase.open(part, 1, "self", "独り言")
    %{changes: _}     = ins_phase_2 = Phase.open(part, 2, "talk", "発言")

    section_id = "#{part.id}-0"
    %{changes: _} = ins_chat_1 = Chat.open(phase, 1, section_id, style, caption)
    %{changes: _} = ins_chat_2 = Chat.open(phase, 2, section_id, style, rule)

    res = Ecto.Multi.new
    |> Ecto.Multi.insert(:book,     ins_book)
    |> Ecto.Multi.insert(:part,     ins_part)
    |> Ecto.Multi.insert(:phase_0,  ins_phase_0)
    |> Ecto.Multi.insert(:phase_1,  ins_phase_1)
    |> Ecto.Multi.insert(:phase_2,  ins_phase_2)
    |> Ecto.Multi.insert(:_caption, ins_chat_1)
    |> Ecto.Multi.insert(:_rule,    ins_chat_2)
    |> Repo.transaction()

    case res do
      {:ok, %{book: book}} -> render_show  conn, book
      {:error, at, c, _}   -> render_error conn, c, at
    end
  end

  def update(conn, %{"id" => id, "book" => params}) do
    src = Repo.get!(Book, id)
    cs  = Book.changeset(src, params)
    case Repo.update(cs) do
      {:ok, dst} -> render_show  conn, dst
      e          -> render_error conn, cs, e
    end
  end

  def delete(conn, %{"id" => id}) do
    src = Repo.get!(Book, id)
    {parts, phases} = query_by src

    multi = Ecto.Multi.new
    Ecto.Multi.update(multi, :book, Book.close(src))
    for o <- parts,  do: Ecto.Multi.update(multi, :part,    Part.close(o))
    for o <- phases, do: Ecto.Multi.update(multi, :phase,   Phase.close(o))
    res = Repo.transaction multi

    case res do
      {:ok, _}           -> render_show  conn, Repo.get!(Book, src.id)
      {:error, at, c, _} -> render_error conn, c, at
    end
  end

  defp query_by(book) do
    parts  = Repo.all(assoc(book, :parts))
    phases = Repo.all(assoc(book, :phases))
    {parts, phases}
  end

  defp render_show(conn, book) do
    {parts, phases} = query_by book
    conn
    |> render(book: book, parts: parts, phases: phases)
  end
end
