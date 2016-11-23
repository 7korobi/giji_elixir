defmodule GijiElixir.PotofView do
  use GijiElixir.Web, :view

  def render("index.json", %{potofs: potofs}) do
    %{data: render_many(potofs, GijiElixir.PotofView, "potof.json")}
  end

  def render("show.json", %{potof: potof}) do
    %{data: render_one(potof, GijiElixir.PotofView, "potof.json")}
  end

  def render("potof.json", %{potof: potof}) do
    %{id: potof.id,
      user_id: potof.user_id,
      book_id: potof.book_id,
      part_id: potof.part_id,
      section_id: potof.section_id,
      name: potof.name,
      job: potof.job,
      sign: potof.sign,
      face_id: potof.face_id,
      state: potof.state}
  end
end
