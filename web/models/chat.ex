defmodule Giji.Chat do
  use Giji.Web, :model
  alias Giji.Chat

  @primary_key false
  schema "chats" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    field :book_id,    :integer, primary_key: true
    field :part_id,    :integer, primary_key: true
    field :phase_id,   :integer, primary_key: true
    field :chat_id,    :integer, primary_key: true
    field :section_id, :integer
    field :potof_id,   :integer
    belongs_to :user,  User

    field :to,    :string
    field :style, :string
    field :log,   :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}, keys \\ [:book_id]) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, [:book_id])
    |> validate_required([:book_id, :part_id, :phase_id, :chat_id, :section_id, :potof_id, :style, :log])
  end

  def open(book, chat_id, style, log) do
    changeset(%Chat{part_id: 0, phase_id: 0, chat_id: chat_id, section_id: 1, potof_id: 0, style: style, log: log}, book, [:book_id])
  end
end


