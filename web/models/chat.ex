defmodule Giji.Chat do
  use Giji.Web, :model

  @primary_key false
  schema "chats" do
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

    timestamps
    field :msec_at, :integer
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}, keys \\ [:book_id]) do
    now = :os.system_time(:milli_seconds)

    struct
    |> cast(%{msec_at: now}, [:msec_at])
    |> cast(params, [:book_id])
    |> validate_required([:book_id, :part_id, :phase_id, :chat_id, :section_id, :potof_id, :style, :log])
  end
end


