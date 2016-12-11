defmodule Giji.Card do
  use Giji.Web, :model

  schema "cards" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    belongs_to :potof, Potof
    belongs_to :part, Part, define_field: false
    belongs_to :book, Book, define_field: false
    field :part_id, :string
    field :book_id, :string

    field :name, :string
    field :state, :integer
  end

  # カードの束ね方をきめる
  # live    talk  talk  talk  talk  jury
  # live    vote  vote  vote  vote  vote
  # role          wolf  wolf
  # role                bite
  # gift                      wolf
  # sub                       

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, [:book_id, :part_id, :potof_id, :name, :state])
    |> validate_required([:book_id, :part_id, :potof_id, :name, :state])
  end
end
