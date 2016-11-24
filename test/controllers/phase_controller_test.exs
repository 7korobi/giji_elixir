defmodule Giji.PhaseControllerTest do
  use Giji.ConnCase

  alias Giji.Phase
  @valid_attrs %{book_id: 42, chat_id: 42, name: "some content", part_id: 42, side_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, phase_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    phase = Repo.insert! %Phase{}
    conn = get conn, phase_path(conn, :show, phase)
    assert json_response(conn, 200)["data"] == %{"id" => phase.id,
      "user_id" => phase.user_id,
      "book_id" => phase.book_id,
      "part_id" => phase.part_id,
      "side_id" => phase.side_id,
      "chat_id" => phase.chat_id,
      "name" => phase.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, phase_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, phase_path(conn, :create), phase: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Phase, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, phase_path(conn, :create), phase: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    phase = Repo.insert! %Phase{}
    conn = put conn, phase_path(conn, :update, phase), phase: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Phase, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    phase = Repo.insert! %Phase{}
    conn = put conn, phase_path(conn, :update, phase), phase: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    phase = Repo.insert! %Phase{}
    conn = delete conn, phase_path(conn, :delete, phase)
    assert response(conn, 204)
    refute Repo.get(Phase, phase.id)
  end
end
