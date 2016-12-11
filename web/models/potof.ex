defmodule Giji.Potof do
  use Giji.Web, :model
  alias Giji.{Book, Part, Potof}

  schema "potofs" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    belongs_to :user, User
    belongs_to :part, Part, define_field: false
    belongs_to :book, Book, define_field: false
    field :part_id, :string
    field :book_id, :string

    field :name,    :string
    field :job,     :string
    field :sign,    :string
    field :face_id, :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(potof, params \\ %{}) do
    now = :os.system_time(:milli_seconds)

    potof
    |> change(open_at: potof.open_at || now, write_at: now)
    |> cast(params, [:book_id, :part_id, :name, :job, :sign, :face_id])
    |> validate_required([:book_id, :part_id, :name, :job, :sign, :face_id])
  end

  def open(%{close_at: nil} = book, params) do
    now = :os.system_time(:milli_seconds)

    %Potof{}
    |> change(open_at: now, write_at: now)
    |> cast(params, [:book_id, :part_id, :name, :job, :sign, :face_id])
    |> validate_required([:book_id, :part_id, :name, :job, :sign, :face_id])
  end

  def open(%{close_at: msec}, _) do
    IO.inspect msec
  end

  def close(potof) do
    now = :os.system_time(:milli_seconds)
    potof
    |> change(close_at: now, write_at: now)
  end
end
