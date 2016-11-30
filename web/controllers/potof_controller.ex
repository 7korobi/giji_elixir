defmodule Giji.PotofController do
  use Giji.Web, :controller

  alias Giji.Potof

  def index(conn, _params) do
    potofs = Repo.all(Potof)
    render(conn, "index.json", potofs: potofs)
  end

  def create(conn, %{"potof" => potof_params}) do
    changeset = Potof.changeset(%Potof{}, potof_params)

    case Repo.insert(changeset) do
      {:ok, potof} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", potof_path(conn, :show, potof, potof))
        |> render("show.json", potof: potof)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Giji.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    potof = Repo.get!(Potof, id)
    render(conn, "show.json", potof: potof)
  end

  def update(conn, %{"id" => id, "potof" => potof_params}) do
    potof = Repo.get!(Potof, id)
    changeset = Potof.changeset(potof, potof_params)

    case Repo.update(changeset) do
      {:ok, potof} ->
        render(conn, "show.json", potof: potof)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Giji.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    potof = Repo.get!(Potof, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(potof)

    send_resp(conn, :no_content, "")
  end
end
