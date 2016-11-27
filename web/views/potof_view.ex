defmodule Giji.PotofView do
  use Giji.Web, :view

  def render("index.json", %{potofs: potofs}) do
    %{data: render_many(potofs, Giji.PotofView, "potof.json")}
  end

  def render("show.json", %{potof: potof}) do
    %{data: render_one(potof, Giji.PotofView, "potof.json")}
  end

  def render("potof.json", %{potof: o}) do
    %{id: o.id,
      user_id: o.user_id,
      book_id: o.book_id,
      part_id: o.part_id,
      section_id: o.section_id,
      msec_at: o.msec_at,
      name: o.name,
      job: o.job,
      sign: o.sign,
      face_id: o.face_id,
      state: o.state}
  end
end
