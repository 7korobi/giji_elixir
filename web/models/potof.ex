defmodule Giji.Potof do
  use Giji.Web, :model
  alias Giji.Potof

  schema "potofs" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    belongs_to :user,  User
    belongs_to :part,  Part
    belongs_to :book, Book, define_field: false
    field :book_id, :string

    field :name,    :string
    field :job,     :string
    field :sign,    :string
    field :face_id, :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, [:book_id, :part_id, :section_id, :name, :job, :sign, :face_id])
    |> validate_required([:book_id, :part_id, :section_id, :name, :job, :sign, :face_id])
  end
end
