defmodule Giji.SectionView do
  use Giji.Web, :view

  def render("public.json", %{section: o}) do
    Map.take o, [
      :open_at, :write_at, :close_at,
      :book_id, :part_id, :section_id,
      :name
    ]
  end
end
