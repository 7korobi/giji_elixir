defmodule Giji.UserTest do
  use Giji.ModelCase

  alias Giji.User

  @valid_attrs %{avatar: "some content", name: "some content", user_id: []}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
