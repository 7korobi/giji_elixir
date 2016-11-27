defmodule Giji.Phase do
  use Giji.Web, :model

  @primary_key false
  schema "phases" do
    field :book_id,  :integer, primary_key: true
    field :part_id,  :integer, primary_key: true
    field :phase_id, :integer, primary_key: true
    belongs_to :user,  User

    field :chat_id, :integer
    field :name, :string

    timestamps
    field :msec_at, :integer
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}, keys \\ [:book_id, :part_id, :phase_id, :chat_id, :name]) do
    now = :os.system_time(:milli_seconds)

    struct
    |> cast(%{msec_at: now}, [:msec_at])
    |> cast(params, keys)
    |> validate_required([:book_id, :part_id, :phase_id, :chat_id, :name])
  end
end
