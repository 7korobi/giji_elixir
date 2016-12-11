defmodule Giji.ChatController do
  use Giji.Web, :api_controller

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
      {:ok, %{chat: data}} -> render_show  conn, data
      {:error, at, c, _}   -> render_error conn, c, at
    end
  end

  def update(conn, %{"id" => id, "chat" => params}) do
    src = Repo.get!(Chat, id)
    dst = Chat.changeset(src, params)
    case Repo.update(dst) do
      {:ok, data} -> render_show  conn, data
      e        -> render_error conn, dst, e
    end
  end

  def delete(conn, %{"id" => id}) do
    src = Repo.get!(Chat, id)

    Repo.delete!(src)
    render_show conn, src
  end

  defp render_show(conn, chat) do
    conn
    |> render(chat: chat)
  end
end
