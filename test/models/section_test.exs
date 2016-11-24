defmodule Giji.SectionTest do
  use Giji.ModelCase

  alias Giji.Section

  @valid_attrs %{book_id: 42, name: "some content", part_id: 42, section_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Section.changeset(%Section{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Section.changeset(%Section{}, @invalid_attrs)
    refute changeset.valid?
  end
end
