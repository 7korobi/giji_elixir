defmodule Giji.PotofTest do
  use Giji.ModelCase

  alias Giji.Potof

  @valid_attrs %{book_id: 42, face_id: "some content", job: "some content", name: "some content", part_id: 42, section_id: 42, sign: "some content", state: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Potof.changeset(%Potof{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Potof.changeset(%Potof{}, @invalid_attrs)
    refute changeset.valid?
  end
end
