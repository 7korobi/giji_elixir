defmodule Giji.ChatController do
  use Giji.Web, :controller

  alias Giji.{Book, Part, Section, Phase, Chat}

  def index(conn, %{"section_id" => section_id}) do
    chats = Repo.all( from o in Chat, where: o.section_id == ^section_id)
    # phase
    #  42-0-0 All   set   Caution Info        Talk Head Calc
    #  42-0-1 xxxx  think         Info Action Talk Head Calc
    #  42-0-2 P2    talk  Caution Info Action Talk Head Calc
    #  42-0-3 P3    buddy         Info Action Talk Head Calc

    #  42-1-0 All   set   Caution Info        Talk Head Calc
    #  42-1-1 xxxx  think         Info Action Talk Head Calc
    #  42-1-2 P2    talk  Caution Info Action Talk Head Calc
    #  42-1-3 P3    grave         Info Action Talk Head Calc
    #  42-1-4 P4    wokf          Info Action Talk Head Calc
    #  42-1-5 P5    alien         Info Action Talk Head Calc
    #  42-1-6 P6    buddy         Info Action Talk Head Calc
    #  42-1-7 P7    buddy         Info Action Talk Head Calc

    conn
    |> put_status(200)
    |> put_resp_header("location", chat_path(conn, :index, section_id))
    |> render(chats: chats)
  end

  def create(conn, %{"chat" => params}) do
    %{"phase_id" => phase_id} = params
    phase = Repo.get!(Phase, phase_id)

    ins_chat  = Chat.add(phase, params)
    upd_phase = Phase.succ(phase)

    res = Ecto.Multi.new
    |> Ecto.Multi.insert(:chat,  ins_chat)
    |> Ecto.Multi.update(:phase, upd_phase)
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
      {:ok, data} -> render_show  conn, :ok, data
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
