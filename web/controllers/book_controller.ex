defmodule Giji.BookController do
  use Giji.Web, :controller

  alias Giji.{Book, Part, Section, Phase, Chat}

  def index(conn, _params) do
    books = Repo.all(from o in Book)
    conn
    |> put_status(200)
    |> put_resp_header("location", book_path(conn, :index))
    |> render(books: books)
  end

  def show(conn, %{"id" => id}) do
    render_show conn, :ok, id
  end

  def create(conn, %{"book" => params}) do
    ins_book = Book.open(params)
    b = ins_book.changes
    style   = params["style"]
    rule    = params["rule"]
    caption = params["caption"]

    res = Ecto.Multi.new
    |> Ecto.Multi.insert(:book,     ins_book)
    |> Ecto.Multi.insert(:part,     Part.open(b))
    |> Ecto.Multi.insert(:phase,    Phase.open(b))
    |> Ecto.Multi.insert(:_caption, Chat.open(b, 1, style, caption))
    |> Ecto.Multi.insert(:_rule,    Chat.open(b, 2, style, rule))
    |> Repo.transaction()

    case res do
      {:ok, %{book: book}} -> render_show  conn, :created, book.id
      {:error, at, c, _}   -> render_error conn, c, at
    end
  end

  def update(conn, %{"id" => id, "book" => book}) do
    src = Repo.get!(Book, id)
    dst = Book.changeset(src, book)
    case Repo.update(dst) do
      {:ok, _} -> render_show  conn, :ok, id
      e        -> render_error conn, dst, e
    end
  end

  def delete(conn, %{"id" => id}) do
    {book, parts, phases} = query_by id

    multi = Ecto.Multi.new
    Ecto.Multi.update(multi, :book, Book.close(book))
    for o <- parts,    do: Ecto.Multi.update(multi, :part,    Part.close(o))
    for o <- phases,   do: Ecto.Multi.update(multi, :phase,   Phase.close(o))
    res = Repo.transaction multi

    case res do
      {:ok, _} -> render_show  conn, :ok, id
      {:error, at, c, _}   -> render_error conn, c, at
    end
  end

  defp query_by(id) do
    book   = Repo.get!(Book, id)
    parts  = Repo.all(assoc(book, :parts))
    phases = Repo.all(assoc(book, :phases))
    {book, parts, phases}
  end

  defp render_show(conn, status, id) do
    {book, parts, phases} = query_by id
    chats = Repo.all(Chat.setting(Chat, book))

    if book && parts && phases && chats do
      conn
      |> put_status(status)
      |> put_resp_header("location", book_path(conn, :show, id))
      |> render(book: book, parts: parts, phases: phases, chats: chats)
    else
      render_error conn, nil, nil
    end
  end

  defp render_error(conn, cs, at) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(Giji.ChangesetView, "error.json", changeset: cs, at: at)
  end
end
