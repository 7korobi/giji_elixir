defmodule GijiElixir.Book do
  use GijiElixir.Web, :model

  schema "books" do
    field :book_id, :integer
    field :part_id, :integer
    field :name, :string
    belongs_to :user, GijiElixir.User

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
