defmodule Giji.Section do
  use Giji.Web, :model
  alias Giji.Section

  @primary_key false
  schema "sections" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    field :book_id,    :integer, primary_key: true
    field :part_id,    :integer, primary_key: true
    field :section_id, :integer, primary_key: true
    belongs_to :user,     User

    field :name, :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}, keys \\ [:book_id, :part_id, :section_id, :name]) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, keys)
    |> validate_required([:book_id, :part_id, :section_id, :name])
  end

  def open(book) do
    changeset(%Section{part_id: 0, section_id: 1, name: "1"}, book, [:book_id])
  end

  def close(section) do
    now = :os.system_time(:milli_seconds)

    section
    |> change(write_at: now, close_at: now)
  end
end
