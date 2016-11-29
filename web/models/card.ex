defmodule Giji.Card do
  use Giji.Web, :model

  schema "cards" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    field :part_id,  :integer
    belongs_to :potof, Potof
    belongs_to :book,  Book

    field :name, :string
    field :state, :integer
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, [:book_id, :part_id, :potof_id, :name, :state])
    |> validate_required([:book_id, :part_id, :potof_id, :name, :state])
  end
end
