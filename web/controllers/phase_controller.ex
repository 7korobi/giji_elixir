defmodule Giji.PhaseController do
  use Giji.Web, :controller

  alias Giji.Phase

  def index(conn, _params) do
    phases = Repo.all(Phase)
    render(conn, "index.json", phases: phases)
  end

  def create(conn, %{"phase" => phase_params}) do
    changeset = Phase.changeset(%Phase{}, phase_params)

    case Repo.insert(changeset) do
      {:ok, phase} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", phase_path(conn, :show, phase))
        |> render("show.json", phase: phase)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Giji.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    phase = Repo.get!(Phase, id)
    render(conn, "show.json", phase: phase)
  end

  def update(conn, %{"id" => id, "phase" => phase_params}) do
    phase = Repo.get!(Phase, id)
    changeset = Phase.changeset(phase, phase_params)

    case Repo.update(changeset) do
      {:ok, phase} ->
        render(conn, "show.json", phase: phase)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Giji.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    phase = Repo.get!(Phase, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(phase)

    send_resp(conn, :no_content, "")
  end
end
