defmodule Giji.BookView do
  use Giji.Web, :view

  def render("public.json", %{book: o}) do
    Map.take o, [
      :open_at, :write_at, :close_at,
      :id,
      :name
    ]
  end

  def render(_, %{book: book, parts: parts, phases: phases}) do
    %{parts:    render_many(parts,    Giji.PartView,    "public.json"),
      phases:   render_many(phases,   Giji.PhaseView,   "public.json"),
      book: render_one(book, Giji.BookView, "public.json")
    }
  end

  def render(_, %{books: books}) do
    %{books: render_many(books, Giji.BookView, "public.json")}
  end
end
