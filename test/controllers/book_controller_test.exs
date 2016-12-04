defmodule Giji.BookControllerTest do
  use Giji.ConnCase

  alias Giji.Book
  @created_json %{
    "book"     =>  %{"id" => "42", "name" => "新しい村"},
    "parts"    => [%{"book_id" => "42", "id" => "42-0", "name" => "プロローグ"}],
    "phases"   => [%{"book_id" => "42", "id" => "42-0-0", "name" => "設定"}]
  }
  @err_name_blank %{"errors" => %{"name" => ["can't be blank"]}}

  # TODO: dummy login.

  @valid_attrs %{
    id: "42",
    style: "head",
    name: "新しい村",
    rule: "あいうえお",
    caption: "村の設定でござる。"
  }
  @invalid_attrs %{id: "42", name: ""}

  def create(conn, attrs) do
    conn = post conn, book_path(conn, :create), book: attrs
    book = Repo.get(Book, attrs.id)
    {conn, book}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    url = book_path(conn, :index)
    assert %{"books" => []} = conn |> get(url) |> json_response(200)
  end

  test "shows chosen resource", %{conn: conn} do
    {conn, book} = create(conn, @valid_attrs)
    url = book_path(conn, :show, book)

    assert @created_json = conn |> get(url) |> json_response(200)
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    url = book_path(conn, :show, -1)
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
    {conn, book} = create(conn, @valid_attrs)
    url = book_path(conn, :update, book)

    assert @created_json = conn |> put(url, book: @valid_attrs) |> json_response(200)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    {conn, book} = create(conn, @valid_attrs)
    url = book_path(conn, :update, book)

    assert @err_name_blank = conn |> put(url, book: @invalid_attrs) |> json_response(422)
  end

  test "deletes chosen resource", %{conn: conn} do
    {conn, book} = create(conn, @valid_attrs)
    url = book_path(conn, :delete, book)

    assert @created_json = conn |> delete(url) |> json_response(200)
  end
end
