defmodule Giji.Potof do
  use Giji.Web, :model

  schema "potofs" do
    field :part_id,    :integer
    field :section_id, :integer
    belongs_to :user,  User
    belongs_to :book,  Book
    has_many   :cards, Card

    has_one    :part,    Part
    has_one    :section, Section

    field :name,    :string
    field :job,     :string
    field :sign,    :string
    field :face_id, :string
    field :state,   :integer

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
    |> cast(params, [:book_id, :part_id, :section_id, :name, :job, :sign, :face_id, :state])
    |> validate_required([:book_id, :part_id, :section_id, :name, :job, :sign, :face_id, :state])
  end
end
