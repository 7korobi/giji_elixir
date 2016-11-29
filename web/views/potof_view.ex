defmodule Giji.PotofView do
  use Giji.Web, :view

  def render("index.json", %{potofs: potofs}) do
    %{data: render_many(potofs, Giji.PotofView, "potof.json")}
  end

  def render("show.json", %{potof: potof}) do
    %{data: render_one(potof, Giji.PotofView, "potof.json")}
  end

  def render("potof.json", %{potof: o}) do
    Map.take o, [
      :open_at, :write_at, :close_at,
      :book_id, :part_id, :section_id,
      :name, :job, :sign, :face_id, :state
    ]
  end
end
