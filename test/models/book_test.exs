defmodule Giji.BookTest do
  use Giji.ModelCase

  alias Giji.Book

  @valid_attrs %{book_id: 42, name: "some content", part_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Book.changeset(%Book{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Book.changeset(%Book{}, @invalid_attrs)
    refute changeset.valid?
  end
end
