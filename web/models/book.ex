defmodule Giji.Book do
  use Giji.Web, :model
  alias Giji.Book

  @primary_key {:book_id, :integer, []}
  @derive {Phoenix.Param, key: :book_id}
  schema "books" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    belongs_to :user, User

    field :part_id, :integer
    field :name,    :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}, keys \\ [:book_id, :name]) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, keys)
    |> validate_required([:book_id, :part_id, :name])
  end

  def open(book) do
    changeset(%Book{part_id: 1}, book, [:book_id, :name])
  end

  def close(book) do
    now = :os.system_time(:milli_seconds)

    book
    |> change(write_at: now, close_at: now)
  end
end
