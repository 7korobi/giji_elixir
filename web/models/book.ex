defmodule Giji.Book do
  use Giji.Web, :model
  alias Giji.Book
  alias Giji.Part
  alias Giji.Section
  alias Giji.Phase
  alias Giji.Chat

  @primary_key {:book_id, :integer, []}
  @derive {Phoenix.Param, key: :book_id}
  schema "books" do
    belongs_to :user,     User

    field :part_id, :integer
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:book_id, :part_id, :name])
    |> validate_required([:book_id, :part_id, :name])
  end

  def start(id, name, setting) do
    Ecto.Multi.new
    |> Ecto.Multi.insert(:book,    Book .changeset(%Book{},  %{book_id: id, name: name, part_id: 1}))
    |> Ecto.Multi.insert(:part,    Part .changeset(%Part{},  %{book_id: id, part_id: 0, name: "プロローグ", section_id: 2}))
    |> Ecto.Multi.insert(:phase,   Phase.changeset(%Phase{}, %{book_id: id, part_id: 0, phase_id: 0, name: "設定", chat_id: 1}))
    |> Ecto.Multi.insert(:chat,    Chat .changeset(%Chat{},  %{book_id: id, part_id: 0, phase_id: 0, chat_id: 0, section_id: 1, potof_id: 0, style: "head", log: setting}))
    |> Ecto.Multi.insert(:section, Section.changeset(%Section{}, %{book_id: id, part_id: 0, section_id: 1, name: "1"}))
  end
end


