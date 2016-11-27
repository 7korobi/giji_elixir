defmodule Giji.GenerateTest do
  use Giji.ModelCase
  alias Giji.Book
  alias Giji.Part
  alias Giji.Section
  alias Giji.Phase
  alias Giji.Chat

  test "book cleanup task" do
    case Repo.get_by(Book,  book_id: 42) do
      nil -> nil
      o -> Repo.delete o
    end
    case Repo.get_by(Part,  book_id: 42, part_id: 0) do
      nil -> nil
      o -> Repo.delete o
    end
    case Repo.get_by(Phase, book_id: 42, part_id: 0, phase_id: 0) do
      nil -> nil
      o -> Repo.delete o
    end
    case Repo.get_by(Chat,  book_id: 42, part_id: 0, phase_id: 0, chat_id: 0) do
      nil -> nil
      o -> Repo.delete o
    end
    case Repo.get_by(Section, book_id: 42, part_id: 0, section_id: 1) do
      nil -> nil
      o -> Repo.delete o
    end

  end

  test "book creation task" do
    book  = Book .changeset(%Book{},  %{book_id: 42, name: "新しい村", part_id: 1})
    part  = Part .changeset(%Part{},  %{book_id: 42, part_id: 0, name: "プロローグ", section_id: 2})
    phase = Phase.changeset(%Phase{}, %{book_id: 42, part_id: 0, phase_id: 0, name: "設定", chat_id: 1})
    chat  = Chat .changeset(%Chat{},  %{book_id: 42, part_id: 0, phase_id: 0, chat_id: 0, section_id: 1, potof_id: 0, to: "ALL", style: "plain", log: "村の設定でござる。"})

    section = Section.changeset(%Section{}, %{book_id: 42, part_id: 0, section_id: 1, name: "1"})

    assert {:ok, _} = Repo.insert(book)
    assert {:ok, _} = Repo.insert(part)
    assert {:ok, _} = Repo.insert(section)
    assert {:ok, _} = Repo.insert(phase)
    assert {:ok, _} = Repo.insert(chat)
  end
end
