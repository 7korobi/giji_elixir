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
    case Book.start(42, "新しい村", "村の設定でござる。") do
      [book, part, phase, chat, section] ->
        assert {:ok, _} = Repo.insert(book)
        assert {:ok, _} = Repo.insert(part)
        assert {:ok, _} = Repo.insert(section)
        assert {:ok, _} = Repo.insert(phase)
        assert {:ok, _} = Repo.insert(chat)
    end
  end
end
