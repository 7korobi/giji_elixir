defmodule Giji.Book do
  use Giji.Web, :model

  schema "books" do
    field :book_id, :integer, primary_key: true
    belongs_to :user,     User
    has_many   :potofs,   Potof
    has_many   :cards,    Card

    has_many   :parts,    Part
    has_many   :sections, Section
    has_many   :phases,   Phase
    has_many   :chats,    Chat

    field :part_id, :integer
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:book_id, :part_id, :name])
    |> validate_required([:book_id, :part_id, :name])
  end
end
