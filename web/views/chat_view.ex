defmodule Giji.ChatView do
  use Giji.Web, :view

  def render("public.json", %{chat: o}) do
    Map.take o, [
      :open_at, :write_at, :close_at,
      :id, :section_id, :potof_id,
      :to, :style, :log
    ]
  end

  def render(_, %{chat: chat}) do
    %{chat: render_one(chat, Giji.ChatView, "public.json")}
  end

  def render(_, %{chats: chats}) do
    %{chats: render_many(chats, Giji.ChatView, "public.json")}
  end
end
