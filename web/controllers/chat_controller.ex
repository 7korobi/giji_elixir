defmodule Giji.ChatController do
  use Giji.Web, :controller

  alias Giji.{Book, Part, Section, Phase, Chat}

  def index(conn, %{"section_id" => section_id}) do
    chats = Repo.all( from o in Chat, where: o.section_id == ^section_id)
    conn
    |> put_status(200)
    |> put_resp_header("location", chat_path(conn, :index, section_id))
    |> render(chats: chats)
  end

  def create(conn, %{"section_id" => section_id, "phase_id" => phase_id, "chat" => params}) do
    [part_id] = Regex.run ~r/^[^-]+-[^-]+/, phase_id
    part    = Repo.get!(Part, part_id)
    phase   = Repo.get!(Phase, phase_id)

    res = Ecto.Multi.new
    |> Ecto.Multi.insert(:chat,  Chat.add(section_id, phase, params))
    |> Ecto.Multi.update(:phase, Phase.succ(phase))
    |> Repo.transaction()

    case res do
      {:ok, %{chat: chat}} -> render_show  conn, :created, chat
      {:error, at, c, _}   -> render_error conn, c, at
    end
  end

  def update(conn, %{"id" => id, "chat" => params}) do
    src = Repo.get!(Chat, id)
    dst = Chat.changeset(src, params)
    case Repo.update(dst) do
      {:ok, _} -> render_show  conn, :ok, src
      e        -> render_error conn, dst, e
    end
  end

  def delete(conn, %{"id" => id}) do
    src = Repo.get!(Chat, id)

    Repo.delete!(src)
    render_show conn, :ok, src
  end

  defp query_by(id) do
    chat = Repo.get!(Chat, id)
    {chat}
  end

  defp render_show(conn, status, chat) do
    if chat do
      conn
      |> put_status(status)
      |> put_resp_header("location", chat_path(conn, :index, chat.section_id))
      |> render(chat: chat)
    else
      render_error conn, nil, nil
    end
  end

  defp render_error(conn, cs, at) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(Giji.ChangesetView, "error.json", changeset: cs, at: at)
  end
end
