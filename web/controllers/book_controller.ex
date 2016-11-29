defmodule Giji.BookController do
  use Giji.Web, :controller

  alias Giji.{Book, Part, Section, Phase, Chat}

  def index(conn, _params) do
    books = Repo.all(Book)
    conn
    |> render(books: books)
  end

  def show(conn, %{"id" => book_id}) do
    json_by conn, :ok, book_id
  end

  def update(conn, %{"book" => book}) do
    {book_id, _,_,_,_} = cast(book)

    src = Repo.get_by(Book, book_id: book_id)
    dst = src && Book.changeset(src, book)
    case src && dst && Repo.update(dst) do
      {:ok, _} -> json_by  conn, :ok, book_id
      e        -> json_err conn, dst, e
    end
  end

  def create(conn, %{"book" => book}) do
    {book_id, _, style, rule, caption} = cast(book)

    res = Ecto.Multi.new
    |> Ecto.Multi.insert(:book,     Book.open(book))
    |> Ecto.Multi.insert(:part,     Part.open(book))
    |> Ecto.Multi.insert(:section,  Section.open(book))
    |> Ecto.Multi.insert(:phase,    Phase.open(book))
    |> Ecto.Multi.insert(:_caption, Chat.open(book, 1, style, caption))
    |> Ecto.Multi.insert(:_rule,    Chat.open(book, 2, style, rule))
    |> Repo.transaction()

    case res do
      {:ok, _}           -> json_by  conn, :created, book_id
      {:error, at, c, _} -> json_err conn, c, at
    end
  end

  def delete(conn, %{"id" => book_id}) do
    {book, parts, sections, phases} = db_by book_id

    multi = Ecto.Multi.new
    Ecto.Multi.update(multi, :book,    Book.close(book))
    for o <- parts,    do: Ecto.Multi.update(multi, :part,    Part.close(o))
    for o <- sections, do: Ecto.Multi.update(multi, :section, Section.close(o))
    for o <- phases,   do: Ecto.Multi.update(multi, :phase,   Phase.close(o))
    res = Repo.transaction multi

    case res do
      {:ok, _}           -> json_by  conn, :ok, book_id
      {:error, at, c, _} -> json_err conn, c, at
    end
  end


  defp cast(params) do
    { String.to_integer(params["book_id"], 10),
      params["name"],
      params["style"],
      params["rule"],
      params["caption"]
    }
  end

  defp db_by(book_id) do
    parts    = Repo.all( from o in Part,    where: o.book_id == ^book_id and is_nil(o.close_at) )
    sections = Repo.all( from o in Section, where: o.book_id == ^book_id and is_nil(o.close_at) )
    phases   = Repo.all( from o in Phase,   where: o.book_id == ^book_id and is_nil(o.close_at) )
    book     = Repo.get_by(Book, book_id: book_id)
    {book, parts, sections, phases}
  end

  defp json_by(conn, status, book_id) do
    {book, parts, sections, phases} = db_by book_id
    chats = Repo.all( from o in Chat, where: o.book_id == ^book_id )

    if book && parts && sections && phases && chats do
      conn
      |> put_status(status)
      |> put_resp_header("location", book_path(conn, :show, book_id))
      |> render(book: book, parts: parts, sections: sections, phases: phases, chats: chats)
    else
      json_err conn, nil, nil
    end
  end

  defp json_err(conn, cs, at) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(Giji.ChangesetView, "error.json", changeset: cs, at: at)
  end
end
