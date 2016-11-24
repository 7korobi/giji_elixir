defmodule Giji.CardView do
  use Giji.Web, :view

  def render("index.json", %{cards: cards}) do
    %{data: render_many(cards, Giji.CardView, "card.json")}
  end

  def render("show.json", %{card: card}) do
    %{data: render_one(card, Giji.CardView, "card.json")}
  end

  def render("card.json", %{card: card}) do
    %{id: card.id,
      book_id: card.book_id,
      part_id: card.part_id,
      potof_id: card.potof_id,
      name: card.name,
      state: card.state}
  end
end
