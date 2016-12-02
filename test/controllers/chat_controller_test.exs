defmodule Giji.ChatControllerTest do
  use Giji.ConnCase

  alias Giji.Chat
  @_json %{
    "book"     =>  %{"book_id" => 42, "name" => "新しい村"},
    "parts"    => [%{"book_id" => 42, "part_id" => 0, "name" => "プロローグ"}],
    "phases"   => [%{"book_id" => 42, "part_id" => 0, "phase_id" => 0, "name" => "設定"}],
    "sections" => [%{"book_id" => 42, "part_id" => 0, "section_id" => 1, "name" => "1"}],
  }

  @created_json %{
    "chats" => [
      %{"book_id" => 42, "part_id" => 0, "phase_id" => 0, "section_id" => 1, "chat_id" => 1, "style" => "head", "log" => "村の設定でござる。"},
      %{"book_id" => 42, "part_id" => 0, "phase_id" => 0, "section_id" => 1, "chat_id" => 2, "style" => "head", "log" => "あいうえお"}
    ]
  }
  @err_name_blank %{"errors" => %{"name" => ["can't be blank"]}}

  # TODO: dummy login.

  @valid_attrs %{
    book_id:   "42",
    part_id:    "0",
    phase_id:   "0",
    section_id: "1",
    style: "head",
    log: "あいうえお"
  }
  @invalid_attrs %{
    book_id:   "42",
    part_id:    "0",
    phase_id:   "0",
    section_id: "1",
    style: "head",
    log: ""
  }

  def create(conn, attrs) do
    conn = post conn, chat_path(conn, :create, attrs.book_id, attrs.part_id, attrs.phase_id), chat: attrs
    chat = Repo.get_by(Chat, chat_id: attrs.book_id, part_id: attrs.part_id, phase_id: attrs.phase_id)
    {conn, chat}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    url = chat_path(conn, :index, 42, 0, 0)
    assert %{"chats" => []} = conn |> get(url) |> json_response(200)
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    url = chat_path(conn, :show, -1, 0, 0)
    assert_raise Ecto.NoResultsError, ~r/expected at least one result but got none in query/, fn ->
      conn |> get(url)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    {conn, _} = create(conn, @valid_attrs)

    assert @created_json = conn |> json_response(201)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    {conn, _} = create(conn, @invalid_attrs)
    assert @err_name_blank = conn |> json_response(422)
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    {conn, chat} = create(conn, @valid_attrs)
    url = chat_path(conn, :update, 42, 0, 0, 1)

    assert @created_json = conn |> put(url, chat: @valid_attrs) |> json_response(200)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    {conn, chat} = create(conn, @valid_attrs)
    url = chat_path(conn, :update, 42, 0, 0, 1)

    assert @err_name_blank = conn |> put(url, chat: @invalid_attrs) |> json_response(422)
  end

  test "deletes chosen resource", %{conn: conn} do
    {conn, chat} = create(conn, @valid_attrs)
    url = chat_path(conn, :delete, 42, 0, 0, 1)

    assert @created_json = conn |> delete(url) |> json_response(200)
  end
end
