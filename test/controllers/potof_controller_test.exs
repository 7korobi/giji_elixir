defmodule Giji.PotofControllerTest do
  use Giji.ConnCase

  alias Giji.Potof
  @created_json %{ "potof" =>  %{
    "book_id" => "42",
    "part_id" => "42-0",

    "job" => "花売り",
    "name" => "メアリー",
    "sign" => nil,
    "face_id" => "c01",
  }}
  @err_name_blank %{"errors" => %{"face_id" => ["can't be blank"]}}

  @book_attrs %{
    id: "42",
    style: "head",
    name: "新しい村",
    rule: "あいうえお",
    caption: "村の設定でござる。"
  }

  @valid_attrs %{
    book_id: "42",
    part_id: "42-0",

    job: "花売り",
    name: "メアリー",
    sign: nil,
    face_id: "c01",
  }
  @invalid_attrs %{book_id: "42", part_id: "42-0", face_id: ""}

  def create(conn, %{book_id: book_id, face_id: face_id} = attrs) do
    conn = post conn,  book_path(conn, :create), book: @book_attrs
    conn = post conn, potof_path(conn, :create), potof: attrs

    potof = Repo.get_by(Potof, book_id: book_id, face_id: face_id)
    {conn, potof}
  end

  def create(conn, attrs) do
    conn = post conn,  book_path(conn, :create), book: @book_attrs
    conn = post conn, potof_path(conn, :create), potof: attrs

    {conn, nil}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    {conn, _} = create(conn, @valid_attrs)
    assert @created_json = conn |> json_response(200)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    {conn, _} = create(conn, @invalid_attrs)
    assert @err_name_blank = conn |> json_response(422)
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    {conn, potof} = create(conn, @valid_attrs)
    url = potof_path(conn, :update, potof)

    assert @created_json = conn |> put(url, potof: @valid_attrs) |> json_response(200)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    {conn, potof} = create(conn, @valid_attrs)
    url = potof_path(conn, :update, potof)

    assert @err_name_blank = conn |> put(url, potof: @invalid_attrs) |> json_response(422)
  end

  test "deletes chosen resource", %{conn: conn} do
    {conn, potof} = create(conn, @valid_attrs)
    url = potof_path(conn, :delete, potof)

    assert @created_json = conn |> delete(url) |> json_response(200)
  end
end
