defmodule GijiElixir.ChatView do
  use GijiElixir.Web, :view

  def render("index.json", %{chats: chats}) do
    %{data: render_many(chats, GijiElixir.ChatView, "chat.json")}
  end

  def render("show.json", %{chat: chat}) do
    %{data: render_one(chat, GijiElixir.ChatView, "chat.json")}
  end

  def render("chat.json", %{chat: chat}) do
    %{id: chat.id,
      user_id: chat.user_id,
      book_id: chat.book_id,
      part_id: chat.part_id,
      section_id: chat.section_id,
      channel_id: chat.channel_id,
      chat_id: chat.chat_id,
      potof_id: chat.potof_id,
      to: chat.to,
      style: chat.style,
      log: chat.log}
  end
end
