defmodule Giji.User do
  use Giji.Web, :model
  alias Giji.User

  schema "users" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    field :user_id, {:array, :string}
    field :name, :string
    field :avatar, :string

    has_many :potofs, Potof
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, [:user_id, :name, :avatar])
    |> validate_required([:user_id, :name, :avatar])
  end
end
