defmodule Giji.ChatControllerTest do
  use Giji.ConnCase

  alias Giji.Chat
  @valid_attrs %{book_id: 42, chat_id: 42, log: "some content", part_id: 42, phase_id: 42, potof_id: 42, section_id: 42, style: "some content", to: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, chat_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    chat = Repo.insert! %Chat{}
    conn = get conn, chat_path(conn, :show, chat)
    assert json_response(conn, 200)["data"] == %{"id" => chat.id,
      "user_id" => chat.user_id,
      "book_id" => chat.book_id,
      "part_id" => chat.part_id,
      "section_id" => chat.section_id,
      "phase_id" => chat.phase_id,
      "chat_id" => chat.chat_id,
      "potof_id" => chat.potof_id,
      "to" => chat.to,
      "style" => chat.style,
      "log" => chat.log}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, chat_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, chat_path(conn, :create), chat: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Chat, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, chat_path(conn, :create), chat: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    chat = Repo.insert! %Chat{}
    conn = put conn, chat_path(conn, :update, chat), chat: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Chat, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    chat = Repo.insert! %Chat{}
    conn = put conn, chat_path(conn, :update, chat), chat: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    chat = Repo.insert! %Chat{}
    conn = delete conn, chat_path(conn, :delete, chat)
    assert response(conn, 204)
    refute Repo.get(Chat, chat.id)
  end
end
