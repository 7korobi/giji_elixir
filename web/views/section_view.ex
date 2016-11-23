defmodule GijiElixir.SectionView do
  use GijiElixir.Web, :view

  def render("index.json", %{sections: sections}) do
    %{data: render_many(sections, GijiElixir.SectionView, "section.json")}
  end

  def render("show.json", %{section: section}) do
    %{data: render_one(section, GijiElixir.SectionView, "section.json")}
  end

  def render("section.json", %{section: section}) do
    %{id: section.id,
      user_id: section.user_id,
      book_id: section.book_id,
      part_id: section.part_id,
      section_id: section.section_id,
      name: section.name}
  end
end
