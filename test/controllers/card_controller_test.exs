defmodule Giji.CardControllerTest do
  use Giji.ConnCase

  alias Giji.Card
  @valid_attrs %{book_id: 42, name: "some content", part_id: 42, potof_id: 42, state: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, card_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = get conn, card_path(conn, :show, card)
    assert json_response(conn, 200)["data"] == %{
      "id" => card.id,
      "book_id" => card.book_id,
      "part_id" => card.part_id,
      "potof_id" => card.potof_id,
      "name" => card.name,
      "state" => card.state
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, card_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, card_path(conn, :create), card: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Card, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, card_path(conn, :create), card: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = put conn, card_path(conn, :update, card), card: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Card, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = put conn, card_path(conn, :update, card), card: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = delete conn, card_path(conn, :delete, card)
    assert response(conn, 204)
    refute Repo.get(Card, card.id)
  end
end
