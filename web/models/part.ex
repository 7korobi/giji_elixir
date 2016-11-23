defmodule GijiElixir.Part do
  use GijiElixir.Web, :model

  schema "parts" do
    field :book_id, :integer
    field :part_id, :integer
    field :section_id, :integer
    field :name, :string
    belongs_to :user, GijiElixir.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:book_id, :part_id, :section_id, :name])
    |> validate_required([:book_id, :part_id, :section_id, :name])
  end
end
