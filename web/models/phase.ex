defmodule Giji.Phase do
  use Giji.Web, :model
  alias Giji.Phase

  @primary_key false
  schema "phases" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    field :book_id,  :integer, primary_key: true
    field :part_id,  :integer, primary_key: true
    field :phase_id, :integer, primary_key: true
    belongs_to :user,  User

    field :chat_id, :integer
    field :name, :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}, keys \\ [:book_id, :part_id, :phase_id, :chat_id, :name]) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, keys)
    |> validate_required([:book_id, :part_id, :phase_id, :chat_id, :name])
  end

  def open(book) do
    changeset(%Phase{part_id: 0, phase_id: 0, chat_id: 3, name: "設定"}, book, [:book_id])
  end

  def close(phase) do
    now = :os.system_time(:milli_seconds)

    phase
    |> change(write_at: now, close_at: now)
  end
end
