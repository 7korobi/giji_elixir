defmodule GijiElixir.Chat do
  use GijiElixir.Web, :model

  schema "chats" do
    field :query, :integer
    field :face_id, :string
    field :style, :string
    field :logid, :string
    field :log, :string
    belongs_to :user, GijiElixir.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:query, :face_id, :style, :logid, :log])
    |> validate_required([:query, :face_id, :style, :logid, :log])
  end
end
