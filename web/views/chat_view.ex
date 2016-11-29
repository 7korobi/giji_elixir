defmodule Giji.ChatView do
  use Giji.Web, :view

  def render("public.json", %{chat: o}) do
    Map.take o, [
      :open_at, :write_at, :close_at,
      :book_id, :part_id, :phase_id, :chat_id,
      :section_id, :potof_id,
      :to, :style, :log
    ]
  end
end
