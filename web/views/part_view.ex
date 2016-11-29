defmodule Giji.PartView do
  use Giji.Web, :view

  def render("public.json", %{part: o}) do
    Map.take o, [
      :open_at, :write_at, :close_at,
      :book_id, :part_id,
      :name
    ]
  end
end
