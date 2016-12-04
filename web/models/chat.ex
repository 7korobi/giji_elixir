defmodule Giji.Chat do
  use Giji.Web, :model
  alias Giji.Chat

  @primary_key {:id, :string, []}
  schema "chats" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    field :section_id, :string
    belongs_to :user,  User
    belongs_to :potof, Potof

    field :to,    :string
    field :style, :string
    field :log,   :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, [:id, :section_id, :to, :style, :log])
    |> validate_required([:id, :section_id, :style, :log])
  end

  def open(book, chat_id, style, log) do
    now = :os.system_time(:milli_seconds)
    id = "#{book.id}-0-0-#{chat_id}"
    section_id = "#{book.id}-0-0"
    %Chat{}
    |> change(write_at: now, open_at: now,
              id: id, section_id: section_id, style: style, log: log)
    |> validate_required([:id, :section_id, :style, :log])
  end

  def add(section_id, %{id: phase_id, chat_idx: idx, close_at: nil}, params) do
    now = :os.system_time(:milli_seconds)
    id = "#{phase_id}-#{idx + 1}"

    %Chat{}
    |> change(id: id, section_id: section_id, open_at: now, write_at: now)
    |> cast(params, [:id, :to, :style, :log])
    |> validate_required([:id, :section_id, :style, :log])
  end

  def add(%{close_at: msec}, _) do
    IO.inspect msec
  end

  def setting(query, book) do
    id = "#{book.id}-0-0"
    from o in query, where: o.id == ^id
  end
end


