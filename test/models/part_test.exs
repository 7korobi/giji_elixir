defmodule Giji.PartTest do
  use Giji.ModelCase

  alias Giji.Part

  @valid_attrs %{book_id: 42, name: "some content", part_id: 42, section_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Part.changeset(%Part{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Part.changeset(%Part{}, @invalid_attrs)
    refute changeset.valid?
  end
end
