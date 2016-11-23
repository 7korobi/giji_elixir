defmodule GijiElixir.Card do
  use GijiElixir.Web, :model

  schema "cards" do
    field :book_id, :integer
    field :part_id, :integer
    field :potof_id, :integer
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
