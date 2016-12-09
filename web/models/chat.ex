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

  def open(phase, idx, section_id, style, log) do
    _add("#{phase.id}-#{idx}", phase, %{section_id: section_id, style: style, log: log})
  end

  def add(%{close_at: nil} = phase, params) do
    %{id: phase_id, chat_idx: idx} = phase
    _add("#{phase.id}-#{idx + 1}", phase, params)
  end

  def add(%{close_at: msec}, _) do
    IO.inspect msec
  end

  def setting(query, book) do
    id = "#{book.id}-0-0"
    from o in query, where: o.id == ^id
  end

  defp _add(id, phase, params) do
    now = :os.system_time(:milli_seconds)
    show = Phase.show(phase, nil)
    %Chat{}
    |> change(open_at: now, write_at: now,
              id: id, show: show)
    |> cast(params, [:id, :section_id, :style, :log])
    |> validate_required([:id, :section_id, :style, :log])
  end
end


