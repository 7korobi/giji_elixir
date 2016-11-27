defmodule Giji.Card do
  use Giji.Web, :model

  schema "cards" do
    field :part_id,  :integer
    belongs_to :potof, Potof
    belongs_to :book,  Book

    field :name, :string
    field :state, :integer

    timestamps
    field :msec_at, :integer
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    now = :os.system_time(:milli_seconds)

    struct
    |> cast(%{msec_at: now}, [:msec_at])
    |> cast(params, [:book_id, :part_id, :potof_id, :name, :state])
    |> validate_required([:book_id, :part_id, :potof_id, :name, :state])
  end
end
