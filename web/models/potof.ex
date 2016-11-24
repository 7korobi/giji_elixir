defmodule Giji.Potof do
  use Giji.Web, :model

  schema "potofs" do
    field :book_id,    :integer
    field :part_id,    :integer
    field :section_id, :integer
    belongs_to :user,    User
    has_many   :cards,   Card

    has_one    :book,    Book
    has_one    :part,    Part
    has_one    :section, Section

    field :name,    :string
    field :job,     :string
    field :sign,    :string
    field :face_id, :string
    field :state,   :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:book_id, :part_id, :section_id, :name, :job, :sign, :face_id, :state])
    |> validate_required([:book_id, :part_id, :section_id, :name, :job, :sign, :face_id, :state])
  end
end
