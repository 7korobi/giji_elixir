defmodule Giji.Section do
  use Giji.Web, :model

  @primary_key false
  schema "sections" do
    field :book_id,    :integer, primary_key: true
    field :part_id,    :integer, primary_key: true
    field :section_id, :integer, primary_key: true
    belongs_to :user,     User

    field :name, :string

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
