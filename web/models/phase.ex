defmodule Giji.Phase do
  use Giji.Web, :model
  alias Giji.{Part, Phase}

  @moduledoc """
    phases table
  """

  @primary_key {:id, :string, []}
  schema "phases" do
    field :open_at,    :integer
    field :write_at,   :integer
    field :close_at,   :integer

    belongs_to :user, User
    belongs_to :book, Book, define_field: false
    field :book_id,  :string
    field :chat_idx, :integer
    field :name, :string
    field :handle, :string # mean color
  end

  def show(%{handle: "self"},  %{id: id}), do: "#{id}"
  def show(%{handle: "jury",  id: id}, _), do: id # 陪審
  def show(%{handle: "alien", id: id}, _), do: id # 余所者
  def show(%{handle: "wolf",  id: id}, _), do: id # 狼藉者
  def show(%{handle: "grave", id: id}, _), do: id # 墓下
  def show(%{handle: "talk",  id: id}, _), do: id # 会話
  def show(%{handle: "hide"},          _), do: "H"
  def show(%{handle: "all"},           _), do: "A"

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    now = :os.system_time(:milli_seconds)

    struct
    |> change(open_at: struct.open_at || now, write_at: now)
    |> cast(params, [:id, :book_id, :chat_idx, :name])
    |> validate_required([:id, :chat_idx, :name, :handle])
  end

  def open(part, idx, handle, name) do
    id = "#{part.id}-#{idx}"
    now = :os.system_time(:milli_seconds)

    %Phase{}
    |> change(write_at: now, open_at: now, handle: handle,
              id: id, book_id: part.book_id, chat_idx: 3, name: name)
  end

  def close(phase) do
    now = :os.system_time(:milli_seconds)
    phase
    |> change(write_at: now, close_at: now)
  end

  def succ(phase) do
    now = :os.system_time(:milli_seconds)
    phase
    |> change(write_at: now, chat_idx: phase.chat_idx + 1)
  end
end
