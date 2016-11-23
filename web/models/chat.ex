defmodule GijiElixir.Chat do
  use GijiElixir.Web, :model

  @primary_key false
  schema "chats" do
    field :book_id,    :integer, primary_key: true
    field :part_id,    :integer, primary_key: true
    field :channel_id, :integer, primary_key: true
    field :chat_id,    :integer, primary_key: true
    belongs_to :user, GijiElixir.User

    field :section_id, :integer
    field :potof_id,   :integer
    field :to,    :string
    field :style, :string
    field :log,   :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:book_id, :part_id, :section_id, :channel_id, :chat_id, :potof_id, :to, :style, :log])
    |> validate_required([:book_id, :part_id, :section_id, :channel_id, :chat_id, :potof_id, :to, :style, :log])
  end
end
