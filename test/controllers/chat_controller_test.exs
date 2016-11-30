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


defmodule Giji.ChatControllerTest do
  use Giji.ConnCase

  alias Giji.Chat
  @created_json %{
    "book"     =>  %{"book_id" => 42, "name" => "新しい村"},
    "parts"    => [%{"book_id" => 42, "part_id" => 0, "name" => "プロローグ"}],
    "phases"   => [%{"book_id" => 42, "part_id" => 0, "phase_id" => 0, "name" => "設定"}],
    "sections" => [%{"book_id" => 42, "part_id" => 0, "section_id" => 1, "name" => "1"}],
    "chats" => [
      %{"book_id" => 42, "part_id" => 0, "phase_id" => 0, "section_id" => 1, "chat_id" => 1, "style" => "head", "log" => "村の設定でござる。"},
      %{"book_id" => 42, "part_id" => 0, "phase_id" => 0, "section_id" => 1, "chat_id" => 2, "style" => "head", "log" => "あいうえお"}
    ]
  }

  # TODO: dummy login.

  @valid_attrs %{
    book_id: "42",
    style: "head",
    name: "新しい村",
    rule: "あいうえお",
    caption: "村の設定でござる。"
  }
  @invalid_attrs %{book_id: "43"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, chat_path(conn, :index, 42)
    assert %{"books" => []} = json_response(conn, 200)
  end

  test "shows chosen resource", %{conn: conn} do
    post conn, chat_path(conn, :create), book: @valid_attrs
    book = Repo.get_by(Book, book_id: 42)

    conn = get conn, chat_path(conn, :show, book)
    assert @created_json = json_response(conn, 200)
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    conn = get conn, chat_path(conn, :show, -1)
    assert %{"errors" => %{"data" => ["not found."]}} = json_response(conn, 422)
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, chat_path(conn, :create), book: @valid_attrs
    assert @created_json = json_response(conn, 201)
    assert Repo.get_by(Book, book_id: 42)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, chat_path(conn, :create), book: @invalid_attrs
    assert %{"errors" => %{"name" => ["can't be blank"]}} = json_response(conn, 422)
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    post conn, chat_path(conn, :create), book: @valid_attrs
    book = Repo.get_by(Book, book_id: 42)

    conn = put conn, chat_path(conn, :update, book), book: @valid_attrs
    assert json_response(conn, 200)
    assert Repo.get_by(Book, book_id: 42)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    post conn, chat_path(conn, :create), book: @valid_attrs
    book = Repo.get_by(Book, book_id: 42)

    conn = put conn, chat_path(conn, :update, book), book: @invalid_attrs
    assert %{"errors" => %{"data" => ["not found."]}} = json_response(conn, 422)
  end

  test "deletes chosen resource", %{conn: conn} do
    post conn, chat_path(conn, :create), book: @valid_attrs
    book = Repo.get_by(Book, book_id: 42)

    conn = delete conn, chat_path(conn, :delete, book)
    assert @created_json = json_response(conn, 200)
  end
end
