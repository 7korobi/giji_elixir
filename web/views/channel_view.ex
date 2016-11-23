defmodule GijiElixir.ChannelView do
  use GijiElixir.Web, :view

  def render("index.json", %{channels: channels}) do
    %{data: render_many(channels, GijiElixir.ChannelView, "channel.json")}
  end

  def render("show.json", %{channel: channel}) do
    %{data: render_one(channel, GijiElixir.ChannelView, "channel.json")}
  end

  def render("channel.json", %{channel: channel}) do
    %{id: channel.id,
      user_id: channel.user_id,
      book_id: channel.book_id,
      part_id: channel.part_id,
      channel_id: channel.channel_id,
      chat_id: channel.chat_id,
      name: channel.name}
  end
end
