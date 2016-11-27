defmodule Giji.PhaseView do
  use Giji.Web, :view

  def render("public.json", %{phase: o}) do
    %{book_id: o.book_id,
      part_id: o.part_id,
      phase_id: o.phase_id,
      msec_at: o.msec_at,
      name: o.name
    }
  end
end
