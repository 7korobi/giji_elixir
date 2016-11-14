defmodule GijiElixir.ChatTest do
  use GijiElixir.ModelCase

  alias GijiElixir.Chat

  @valid_attrs %{face_id: "some content", log: "some content", logid: "some content", query: 42, style: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Chat.changeset(%Chat{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Chat.changeset(%Chat{}, @invalid_attrs)
    refute changeset.valid?
  end
end
