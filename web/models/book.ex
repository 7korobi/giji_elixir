defmodule Giji.Book do
  use Giji.Web, :model

  @primary_key {:book_id, :integer, []}
  @derive {Phoenix.Param, key: :book_id}
  schema "books" do
    belongs_to :user,     User

    field :part_id, :integer
    field :name,    :string

    timestamps
    field :msec_at, :integer
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}, keys \\ [:book_id, :name]) do
    now = :os.system_time(:milli_seconds)

    struct
    |> cast(%{msec_at: now}, [:msec_at])
    |> cast(params, keys)
    |> validate_required([:book_id, :part_id, :msec_at, :name])
  end
end
