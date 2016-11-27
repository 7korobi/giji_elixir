defmodule Giji.Section do
  use Giji.Web, :model

  @primary_key false
  schema "sections" do
    field :book_id,    :integer, primary_key: true
    field :part_id,    :integer, primary_key: true
    field :section_id, :integer, primary_key: true
    belongs_to :user,     User

    field :name, :string

    timestamps
    field :msec_at, :integer
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}, keys \\ [:book_id, :part_id, :section_id, :name]) do
    now = :os.system_time(:milli_seconds)

    struct
    |> cast(%{msec_at: now}, [:msec_at])
    |> cast(params, keys)
    |> validate_required([:book_id, :part_id, :section_id, :name])
  end
end
