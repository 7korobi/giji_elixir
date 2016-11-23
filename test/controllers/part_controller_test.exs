defmodule GijiElixir.PartControllerTest do
  use GijiElixir.ConnCase

  alias GijiElixir.Part
  @valid_attrs %{book_id: 42, name: "some content", part_id: 42, section_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, part_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    part = Repo.insert! %Part{}
    conn = get conn, part_path(conn, :show, part)
    assert json_response(conn, 200)["data"] == %{"id" => part.id,
      "user_id" => part.user_id,
      "book_id" => part.book_id,
      "part_id" => part.part_id,
      "section_id" => part.section_id,
      "name" => part.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, part_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, part_path(conn, :create), part: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Part, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, part_path(conn, :create), part: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    part = Repo.insert! %Part{}
    conn = put conn, part_path(conn, :update, part), part: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Part, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    part = Repo.insert! %Part{}
    conn = put conn, part_path(conn, :update, part), part: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    part = Repo.insert! %Part{}
    conn = delete conn, part_path(conn, :delete, part)
    assert response(conn, 204)
    refute Repo.get(Part, part.id)
  end
end
