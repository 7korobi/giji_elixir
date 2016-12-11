defmodule Giji.ChatControllerTest do
  use Giji.ConnCase

  alias Giji.Chat
  @err_name_blank %{"errors" => %{"log" => ["can't be blank"]}}
  @setting_attrs_json %{"chat" => %{
    "id" => "42-0-0-1",
    "potof_id" => nil,
    "section_id" => "42-0-1",
    "close_at" => 0xfffffffffffff,
    "show" => "A",
    "style" => "head",
    "log" => "村の設定を更新でござる。",
  }}
  @valid_attrs_json %{"chat" => %{
    "id" => "42-0-0-4",
    "potof_id" => nil,
    "section_id" => "42-0-1",
    "show" => "A",
    "style" => "plain",
    "log" => "ひとつめのお話。",
  }}

  @book_attrs %{
    id: "42",
    style: "head",
    name: "新しい村",
    rule: "あいうえお",
    caption: "村の設定でござる。"
  }
  @setting_attrs %{
    section_id: "42-0-1",
    phase_id: "42-0-0",
    style: "head",
    log: "村の設定を更新でござる。"
  }
  @valid_attrs %{
    section_id: "42-0-1",
    phase_id: "42-0-0",
    style: "plain",
    log: "ひとつめのお話。"
  }
  @invalid_attrs %{
    section_id: "42-0-1",
    phase_id: "42-0-0",
    style: "plain",
    log: ""
  }

  def create(conn, attrs) do
    conn = post conn, book_path(conn, :create), book: @book_attrs
    conn = post conn, chat_path(conn, :create), chat: attrs
    {conn, nil}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    url = chat_path(conn, :index, "42-0-1")
    assert %{"chats" => []} = conn |> get(url) |> json_response(200)
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    {conn, _} = create(conn, @valid_attrs)

    assert @valid_attrs_json = conn |> json_response(201)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    {conn, _} = create(conn, @invalid_attrs)

    assert @err_name_blank = conn |> json_response(422)
  end

  test "updates and renders chosen resource when data is setting", %{conn: conn} do
    {conn, _} = create(conn, @valid_attrs)
    url = chat_path(conn, :update, "42-0-0-1")

    assert @setting_attrs_json = conn |> put(url, chat: @setting_attrs) |> json_response(200)
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    {conn, _} = create(conn, @valid_attrs)
    url = chat_path(conn, :update, "42-0-0-4")

    assert @valid_attrs_json = conn |> put(url, chat: @valid_attrs) |> json_response(200)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    {conn, _} = create(conn, @valid_attrs)
    url = chat_path(conn, :update, "42-0-0-4")

    assert @err_name_blank = conn |> put(url, chat: @invalid_attrs) |> json_response(422)
  end

  test "deletes chosen resource", %{conn: conn} do
    {conn, chat} = create(conn, @valid_attrs)
    url = chat_path(conn, :delete, "42-0-0-4")

    assert @valid_attrs_json = conn |> delete(url) |> json_response(200)
  end
end
