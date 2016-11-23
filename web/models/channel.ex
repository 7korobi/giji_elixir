defmodule GijiElixir.Channel do
  use GijiElixir.Web, :model

  @primary_key false
  schema "channels" do
    field :book_id,    :integer, primary_key: true
    field :part_id,    :integer, primary_key: true
    field :channel_id, :integer, primary_key: true
    belongs_to :user, GijiElixir.User
    field :chat_id, :integer
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:book_id, :part_id, :channel_id, :chat_id, :name])
    |> validate_required([:book_id, :part_id, :channel_id, :chat_id, :name])
  end
end
