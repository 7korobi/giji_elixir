defmodule Giji.ChatTest do
  use Giji.ModelCase

  alias Giji.Chat

  @valid_attrs %{book_id: 42, chat_id: 42, log: "some content", part_id: 42, phase_id: 42, potof_id: 42, section_id: 42, style: "some content", to: "some content"}
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
