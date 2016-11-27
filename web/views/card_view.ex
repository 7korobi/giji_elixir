defmodule Giji.CardView do
  use Giji.Web, :view

  def render("index.json", %{cards: cards}) do
    %{data: render_many(cards, Giji.CardView, "card.json")}
  end

  def render("show.json", %{card: card}) do
    %{data: render_one(card, Giji.CardView, "card.json")}
  end

  def render("card.json", %{card: o}) do
    %{id: o.id,
      book_id: o.book_id,
      part_id: o.part_id,
      potof_id: o.potof_id,
      msec_at: o.msec_at,
      name: o.name,
      state: o.state}
  end
end
