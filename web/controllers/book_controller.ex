defmodule Giji.BookController do
  use Giji.Web, :controller

  alias Giji.Book
  alias Giji.Part
  alias Giji.Section
  alias Giji.Phase
  alias Giji.Chat

  def index(conn, _params) do
    books = Repo.all(Book)
    conn
    |> render books: books

    # json conn, %{
    #   books: books
    # }
  end

  def create(conn, %{"book" => book}) do
    {book_id, name, style, rule, caption} = cast(book)

    res = Ecto.Multi.new
    |> Ecto.Multi.insert(:book,    Book.changeset(      %Book{part_id: 1}, book, [:book_id, :name]))
    |> Ecto.Multi.insert(:part,    Part.changeset(      %Part{part_id: 0, section_id: 2, name: "プロローグ"},   book, [:book_id]))
    |> Ecto.Multi.insert(:section, Section.changeset(%Section{part_id: 0, section_id: 1, name: "1"},            book, [:book_id]))
    |> Ecto.Multi.insert(:phase,   Phase.changeset(%Phase{  part_id: 0, phase_id: 0, chat_id: 3, name: "設定"}, book, [:book_id]))
    |> Ecto.Multi.insert(:_caption, Chat.changeset( %Chat{  part_id: 0, phase_id: 0, chat_id: 1, section_id: 1, potof_id: 0, style: style, log: caption}, book, [:book_id]))

    |> Ecto.Multi.insert(:_rule,    Chat.changeset( %Chat{  part_id: 0, phase_id: 0, chat_id: 2, section_id: 1, potof_id: 0, style: style, log: rule},    book, [:book_id]))
    |> Repo.transaction()

    case res do
      {:ok, data} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", book_path(conn, :show, data.book))
        |> json_by(book_id)
      {:error, :book, c, e} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(e)
    end
  end

  def show(conn, %{"id" => book_id}) do
    json_by conn, book_id
  end

  def update(conn, %{"book" => book}) do
    {book_id, name,_,_,_} = cast(book)

    src = Repo.get_by(Book, book_id: book_id)
    dst = src && Book.changeset(src, book)
    case src && dst && Repo.update(dst) do
      {:ok, book} ->
        json conn, %{b: 1}
      e ->
        conn
        |> put_status(:unprocessable_entity)
        |> json %{error: e}
    end
  end

  def delete(conn, %{"id" => book_id}) do
    src = Repo.get_by(Book, book_id: book_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    send_resp(conn, :no_content, "")
  end

  defp cast(params) do
    {params["book_id"], params["name"], params["style"], params["rule"], params["caption"]}
  end

  defp json_by(conn, book_id) do
    parts    = Repo.all( from o in Part,    where: o.book_id == ^book_id )
    sections = Repo.all( from o in Section, where: o.book_id == ^book_id )
    phases   = Repo.all( from o in Phase,   where: o.book_id == ^book_id )
    chats    = Repo.all( from o in Chat,    where: o.book_id == ^book_id )
    book = Repo.get_by(Book, book_id: book_id)
    if book && parts && sections && phases && chats do
      conn
      |> render book: book, parts: parts, sections: sections, phases: phases, chats: chats
    else
      conn
      |> put_status(:unprocessable_entity)
      |> json %{error: 1}
    end
    #  json conn, %{
    #    parts: parts,
    #    sections: sections,
    #    phases: phases,
    #    chats: chats,
    #    book: book
    #  }
  end
end
