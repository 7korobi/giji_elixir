defmodule Giji.Part do
  use Giji.Web, :model
  alias Giji.Part

  @moduledoc """
    parts table
  """

  @primary_key {:id, :string, []}
  schema "parts" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    belongs_to :user, User
    belongs_to :book, Book, define_field: false
    field :book_id, :string
    field :section_idx, :integer

    field :name, :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, [:id, :book_id, :section_idx, :name])
    |> validate_required([:id, :section_idx, :name])
  end

  def open(book, idx, name) do
    id = "#{book.id}-#{idx}"
    now = :os.system_time(:milli_seconds)

    %Part{}
    |> change(write_at: now, open_at: now,
              id: id, book_id: book.id, section_idx: 1, name: name)
  end

  def close(part) do
    now = :os.system_time(:milli_seconds)
    part
    |> change(write_at: now, close_at: now)
  end
end
