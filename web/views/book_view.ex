defmodule Giji.BookView do
  use Giji.Web, :view

  def render("index.json", %{books: books}) do
    %{data: render_many(books, Giji.BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, Giji.BookView, "book.json")}
  end

  def render("book.json", %{book: book}) do
    %{id: book.id,
      user_id: book.user_id,
      book_id: book.book_id,
      part_id: book.part_id,
      name: book.name}
  end
end
