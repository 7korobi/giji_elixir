defmodule GijiElixir.Book do
  use GijiElixir.Web, :model

  @primary_key false
  schema "books" do
    field :book_id, :integer, primary_key: true
    belongs_to :user, GijiElixir.User

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
