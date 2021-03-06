defmodule Giji.CardController do
  use Giji.Web, :controller

  alias Giji.Card

  @moduledoc """
    card api
  """

  def index(conn, _params) do
    cards = Repo.all(Card)
    render(conn, "index.json", cards: cards)
  end

  def create(conn, %{"card" => card_params}) do
    changeset = Card.changeset(%Card{}, card_params)

    case Repo.insert(changeset) do
      {:ok, card} ->
        conn
        |> put_status(:created)
        |> render("show.json", card: card)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Giji.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Repo.get!(Card, id)
    render(conn, "show.json", card: card)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Repo.get!(Card, id)
    changeset = Card.changeset(card, card_params)

    case Repo.update(changeset) do
      {:ok, card} ->
        render(conn, "show.json", card: card)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Giji.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Repo.get!(Card, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(card)

    send_resp(conn, :no_content, "")
  end
end
