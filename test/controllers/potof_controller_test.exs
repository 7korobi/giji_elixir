defmodule GijiElixir.PotofControllerTest do
  use GijiElixir.ConnCase

  alias GijiElixir.Potof
  @valid_attrs %{book_id: 42, face_id: "some content", job: "some content", name: "some content", part_id: 42, section_id: 42, sign: "some content", state: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, potof_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    potof = Repo.insert! %Potof{}
    conn = get conn, potof_path(conn, :show, potof)
    assert json_response(conn, 200)["data"] == %{"id" => potof.id,
      "user_id" => potof.user_id,
      "book_id" => potof.book_id,
      "part_id" => potof.part_id,
      "section_id" => potof.section_id,
      "name" => potof.name,
      "job" => potof.job,
      "sign" => potof.sign,
      "face_id" => potof.face_id,
      "state" => potof.state}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, potof_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, potof_path(conn, :create), potof: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Potof, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, potof_path(conn, :create), potof: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    potof = Repo.insert! %Potof{}
    conn = put conn, potof_path(conn, :update, potof), potof: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Potof, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    potof = Repo.insert! %Potof{}
    conn = put conn, potof_path(conn, :update, potof), potof: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    potof = Repo.insert! %Potof{}
    conn = delete conn, potof_path(conn, :delete, potof)
    assert response(conn, 204)
    refute Repo.get(Potof, potof.id)
  end
end
