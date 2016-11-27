defmodule Giji.ChatView do
  use Giji.Web, :view

  def render("public.json", %{chat: o}) do
    %{book_id: o.book_id,
      part_id: o.part_id,
      phase_id: o.phase_id,
      chat_id: o.chat_id,
      section_id: o.section_id,
      potof_id: o.potof_id,
      msec_at: o.msec_at,
      to: o.to,
      style: o.style,
      log: o.log
    }
  end
end
