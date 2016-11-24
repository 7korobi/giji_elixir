defmodule Giji.CardTest do
  use Giji.ModelCase

  alias Giji.Card

  @valid_attrs %{book_id: 42, name: "some content", part_id: 42, potof_id: 42, state: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Card.changeset(%Card{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Card.changeset(%Card{}, @invalid_attrs)
    refute changeset.valid?
  end
end
