defmodule Giji.BookControllerTest do
  use Giji.ConnCase

  alias Giji.Book
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
    conn = get conn, book_path(conn, :index)
    assert %{"books" => []} = json_response(conn, 200)
  end


  test "shows chosen resource", %{conn: conn} do
    post conn, book_path(conn, :create), book: @valid_attrs
    book = Repo.get_by(Book, book_id: 42)

    conn = get conn, book_path(conn, :show, book)
    assert %{
      "book"     =>  %{"book_id" => 42, "name" => "新しい村"},
      "parts"    => [%{"book_id" => 42, "part_id" => 0, "name" => "プロローグ"}],
      "phases"   => [%{"book_id" => 42, "part_id" => 0, "phase_id" => 0, "name" => "設定"}],
      "sections" => [%{"book_id" => 42, "part_id" => 0, "section_id" => 1, "name" => "1"}],
      "chats" => [
        %{"book_id" => 42, "part_id" => 0, "phase_id" => 0, "section_id" => 1, "chat_id" => 1, "style" => "head", "log" => "村の設定でござる。"},
        %{"book_id" => 42, "part_id" => 0, "phase_id" => 0, "section_id" => 1, "chat_id" => 2, "style" => "head", "log" => "あいうえお"}
      ]
    } = json_response(conn, 200)
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    conn = get conn, book_path(conn, :show, -1)
    assert json_response(conn, 422) == %{"error" => 1}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, book_path(conn, :create), book: @valid_attrs
    assert json_response(conn, 201)
    assert Repo.get_by(Book, book_id: 42)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, book_path(conn, :create), book: @invalid_attrs
    assert json_response(conn, 422) == %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    post conn, book_path(conn, :create), book: @valid_attrs
    book = Repo.get_by(Book, book_id: 42)

    conn = put conn, book_path(conn, :update, book), book: @valid_attrs
    assert json_response(conn, 200)
    assert Repo.get_by(Book, book_id: 42)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    post conn, book_path(conn, :create), book: @valid_attrs
    book = Repo.get_by(Book, book_id: 42)

    conn = put conn, book_path(conn, :update, book), book: @invalid_attrs
    assert json_response(conn, 422) == %{"error" => nil}
  end

  test "deletes chosen resource", %{conn: conn} do
    post conn, book_path(conn, :create), book: @valid_attrs
    book = Repo.get_by(Book, book_id: 42)

    conn = delete conn, book_path(conn, :delete, book)
    assert response(conn, 204)
    # TODO assert
  end
end
