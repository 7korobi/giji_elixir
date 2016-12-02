defmodule Giji.PhaseView do
  use Giji.Web, :view

  def render("public.json", %{phase: o}) do
    Map.take o, [
      :open_at, :write_at, :close_at,
      :id, :book_id,
      :name
    ]
  end
end
