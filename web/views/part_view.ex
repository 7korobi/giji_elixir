defmodule GijiElixir.PartView do
  use GijiElixir.Web, :view

  def render("index.json", %{parts: parts}) do
    %{data: render_many(parts, GijiElixir.PartView, "part.json")}
  end

  def render("show.json", %{part: part}) do
    %{data: render_one(part, GijiElixir.PartView, "part.json")}
  end

  def render("part.json", %{part: part}) do
    %{id: part.id,
      user_id: part.user_id,
      book_id: part.book_id,
      part_id: part.part_id,
      section_id: part.section_id,
      name: part.name}
  end
end
