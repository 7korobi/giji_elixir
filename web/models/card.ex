defmodule Giji.Card do
  use Giji.Web, :model

  schema "cards" do
    field :book_id,  :integer
    field :part_id,  :integer
    belongs_to :potof, Giji.Potof

    field :name, :string
    field :state, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:book_id, :part_id, :potof_id, :name, :state])
    |> validate_required([:book_id, :part_id, :potof_id, :name, :state])
  end
end
