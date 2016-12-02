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

  def create(conn, %{"section_id" => section_id, "chat" => chat}) do
    phase_id = "42-0-0"
    %{chat_idx: chat_idx} = Repo.get(Phase, phase_id)
    style = "plain"
    log = "test"
    id = "42-0-0-#{chat_idx + 1}"
    dst = Chat.open("42", id, style, log)
    case Repo.insert(dst) do
      {:ok, c} -> render_show  conn, :created, c.id
      e        -> render_error conn, dst, e
    end
  end

  def update(conn, %{"id" => id, "chat" => chat}) do
    src = Repo.get!(Chat, id)
    dst = Chat.changeset(src, chat)
    case Repo.update(dst) do
      {:ok, _} -> render_show  conn, :ok, id
      e        -> render_error conn, dst, e
    end
  end

  def delete(conn, %{"id" => id}) do
    {chat} = query_by id

    Repo.delete!(chat)
    render_show conn, :ok, id
  end

  defp query_by(id) do
    chat = Repo.get!(Chat, id)
    {chat}
  end

  defp render_show(conn, status, id) do
    {chat} = query_by id

    if chat do
      conn
      |> put_status(status)
      |> put_resp_header("location", chat_path(conn, :show, id))
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
