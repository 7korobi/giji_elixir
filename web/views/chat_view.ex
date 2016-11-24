defmodule Giji.ChatView do
  use Giji.Web, :view

  def render("index.json", %{chats: chats}) do
    %{data: render_many(chats, Giji.ChatView, "chat.json")}
  end

  def render("show.json", %{chat: chat}) do
    %{data: render_one(chat, Giji.ChatView, "chat.json")}
  end

  def render("chat.json", %{chat: chat}) do
    %{id: chat.id,
      user_id: chat.user_id,
      book_id: chat.book_id,
      part_id: chat.part_id,
      section_id: chat.section_id,
      phase_id: chat.phase_id,
      chat_id: chat.chat_id,
      potof_id: chat.potof_id,
      to: chat.to,
      style: chat.style,
      log: chat.log}
  end
end
