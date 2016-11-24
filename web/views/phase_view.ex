defmodule Giji.PhaseView do
  use Giji.Web, :view

  def render("index.json", %{phases: phases}) do
    %{data: render_many(phases, Giji.PhaseView, "phase.json")}
  end

  def render("show.json", %{phase: phase}) do
    %{data: render_one(phase, Giji.PhaseView, "phase.json")}
  end

  def render("phase.json", %{phase: phase}) do
    %{id: phase.id,
      user_id: phase.user_id,
      book_id: phase.book_id,
      part_id: phase.part_id,
      side_id: phase.side_id,
      chat_id: phase.chat_id,
      name: phase.name}
  end
end
