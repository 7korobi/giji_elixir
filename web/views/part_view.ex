defmodule Giji.PartView do
  use Giji.Web, :view

  def render("public.json", %{part: o}) do
    %{book_id: o.book_id,
      part_id: o.part_id,
      msec_at: o.msec_at,
      name: o.name
    }
  end
end
