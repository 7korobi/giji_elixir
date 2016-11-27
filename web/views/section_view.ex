defmodule Giji.SectionView do
  use Giji.Web, :view

  def render("public.json", %{section: o}) do
    %{book_id: o.book_id,
      part_id: o.part_id,
      section_id: o.section_id,
      msec_at: o.msec_at,
      name: o.name
    }
  end
end
