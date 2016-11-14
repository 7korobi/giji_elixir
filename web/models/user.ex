defmodule Giji.User do
  use Giji.Web, :model

  schema "users" do
    field :user_id, {:array, :string}
    field :name, :string
    field :avatar, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :name, :avatar])
    |> validate_required([:user_id, :name, :avatar])
  end
end
