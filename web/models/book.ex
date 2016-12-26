defmodule Giji.Book do
  use Giji.Web, :model
  alias Giji.{Book, User, Part, Phase}

  @moduledoc """
    books table
  """

  @primary_key {:id, :string, []}
  schema "books" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    belongs_to :user, User
    has_many :parts,  Part
    has_many :phases, Phase
    field :part_idx, :integer

    field :name,    :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params, keys \\ [:id, :name]) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, keys)
    |> validate_required([:id, :name])
  end

  def open(book) do
    %Book{part_idx: 1}
    |> changeset(book, [:id, :name])
  end

  def close(book) do
    now = :os.system_time(:milli_seconds)
    book
    |> change(write_at: now, close_at: now)
  end
end
