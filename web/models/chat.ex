defmodule Giji.Chat do
  use Giji.Web, :model
  alias Giji.{Phase, Chat}

  @primary_key {:id, :string, []}
  schema "chats" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    field :section_id, :string
    belongs_to :user,  User
    belongs_to :potof, Potof

    field :show,  :string  # showdown range
    field :style, :string  # CAUTION INFO ACTION TALK HEAD PAPER
    field :log,   :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, [:id, :section_id, :style, :log])
    |> validate_required([:id, :section_id, :show, :style, :log])
  end

  def open(section_id, phase, idx, style, log) do
    now = :os.system_time(:milli_seconds)
    id = "#{phase.id}-#{idx}"
    show = Phase.show(phase, nil)

    %Chat{}
    |> change(write_at: now, open_at: now,
              id: id, section_id: section_id, show: show, style: style, log: log)
    |> validate_required([:id, :section_id, :show, :style, :log])
  end

  def add(section_id, %{close_at: nil} = phase, params) do
    %{id: phase_id, chat_idx: idx} = phase
    now = :os.system_time(:milli_seconds)
    id = "#{phase_id}-#{idx + 1}"
    show = Phase.show(phase, nil)

    %Chat{}
    |> change(open_at: now, write_at: now,
              id: id, section_id: section_id, show: show)
    |> cast(params, [:id, :show, :style, :log])
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


