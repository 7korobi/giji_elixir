defmodule Giji.Book do
  use Giji.Web, :model

  @primary_key {:book_id, :integer, []}
  @derive {Phoenix.Param, key: :book_id}
  schema "books" do
    belongs_to :user,     User

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
