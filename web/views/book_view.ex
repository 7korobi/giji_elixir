defmodule Giji.BookView do
  use Giji.Web, :view

  def render("public.json", %{book: o}) do
    %{book_id: o.book_id,
      msec_at: o.msec_at,
      name:    o.name,
    }
  end

  def render(_, %{book: book, parts: parts, sections: sections, phases: phases, chats: chats}) do
    %{parts:    render_many(parts,    Giji.PartView,    "public.json"),
      sections: render_many(sections, Giji.SectionView, "public.json"),
      phases:   render_many(phases,   Giji.PhaseView,   "public.json"),
      chats:    render_many(chats,    Giji.ChatView,    "public.json"),
      book: render_one(book, Giji.BookView, "public.json")
    }
  end

  def render(_, %{books: books}) do
    %{books: render_many(books, Giji.BookView, "public.json")}
  end
end
