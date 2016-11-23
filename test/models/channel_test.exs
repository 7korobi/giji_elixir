defmodule GijiElixir.ChannelTest do
  use GijiElixir.ModelCase

  alias GijiElixir.Channel

  @valid_attrs %{book_id: 42, channel_id: 42, chat_id: 42, name: "some content", part_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Channel.changeset(%Channel{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Channel.changeset(%Channel{}, @invalid_attrs)
    refute changeset.valid?
  end
end
