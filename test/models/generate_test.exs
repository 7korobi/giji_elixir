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

  test "book create" do
    assert {:ok, _} = Repo.transaction(Book.start(42, "新しい村", "村の設定でござる。"))
    #  {:ok, %{book: book, part: part, phase: phase, chat: chat, section: section}}
    #  {:error, key_that_errored, %{book: book, part: part, phase: phase, chat: chat, section: section}}
  end
end
