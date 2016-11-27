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

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:book_id, :part_id, :phase_id, :chat_id, :section_id, :potof_id, :to, :style, :log])
    |> validate_required([:book_id, :part_id, :phase_id, :chat_id, :section_id, :potof_id, :style, :log])
  end
end


