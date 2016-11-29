defmodule Giji.CardView do
  use Giji.Web, :view

  def render("index.json", %{cards: cards}) do
    %{data: render_many(cards, Giji.CardView, "card.json")}
  end

  def render("show.json", %{card: card}) do
    %{data: render_one(card, Giji.CardView, "card.json")}
  end

  def render("card.json", %{card: o}) do
    Map.take o, [
      :open_at, :write_at, :close_at,
      :id, :book_id, :part_id, :potof_id,
      :name, :state
    ]
  end
end
