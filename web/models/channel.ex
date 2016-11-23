defmodule GijiElixir.Channel do
  use GijiElixir.Web, :model

  schema "channels" do
    field :book_id, :integer
    field :part_id, :integer
    field :channel_id, :integer
    field :chat_id, :integer
    field :name, :string
    belongs_to :user, GijiElixir.User

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
