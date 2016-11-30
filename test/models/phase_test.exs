defmodule Giji.PhaseTest do
  use Giji.ModelCase

  alias Giji.Phase

  @valid_attrs %{book_id: 42, part_id: 42, phase_id: 42, name: "some content", chat_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Phase.changeset(%Phase{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Phase.changeset(%Phase{}, @invalid_attrs)
    refute changeset.valid?
  end
end