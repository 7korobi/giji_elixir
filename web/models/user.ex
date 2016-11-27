defmodule Giji.User do
  use Giji.Web, :model

  schema "users" do
    field :user_id, {:array, :string}
    field :name, :string
    field :avatar, :string

    has_many :potofs, Potof

    timestamps
    field :msec_at, :integer
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    now = :os.system_time(:milli_seconds)

    struct
    |> cast(%{msec_at: now}, [:msec_at])
    |> cast(params, [:user_id, :name, :avatar])
    |> validate_required([:user_id, :name, :avatar])
  end
end
