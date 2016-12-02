defmodule Giji.Phase do
  use Giji.Web, :model
  alias Giji.{Part, Phase}

  @primary_key {:id, :string, []}
  schema "phases" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    belongs_to :user, User
    belongs_to :book, Book, define_field: false
    field :book_id, :string
    field :chat_idx, :integer

    field :name, :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}, keys \\ [:id, :book_id, :chat_idx, :name]) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, keys)
    |> validate_required([:id, :chat_idx, :name])
  end

  def open(book) do
    id = "#{book.id}-0-0"
    now = :os.system_time(:milli_seconds)

    %Phase{}
    |> change(write_at: now, open_at: now,
              id: id, book_id: book.id, chat_idx: 3, name: "設定")
  end

  def close(phase) do
    now = :os.system_time(:milli_seconds)
    phase
    |> change(write_at: now, close_at: now)
  end
end
