defmodule Giji.PartView do
  use Giji.Web, :view

  def render("public.json", %{part: o}) do
    Map.take o, [
      :open_at, :write_at, :close_at,
      :id, :book_id, :section_idx,
      :name
    ]
  end
end
