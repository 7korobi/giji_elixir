defmodule Giji.PotofView do
  use Giji.Web, :view

  def render("public.json", %{potof: o}) do
    Map.take o, [
      :open_at, :write_at, :close_at,
      :id, :book_id, :part_id,
      :name, :job, :sign, :face_id
    ]
  end

  def render(_, %{potof: potof}) do
    %{potof: render_one(potof, Giji.PotofView, "public.json")}
  end

  def render(_, %{potofs: potofs}) do
    %{potofs: render_many(potofs, Giji.PotofView, "public.json")}
  end
end
