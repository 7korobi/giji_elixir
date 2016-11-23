defmodule GijiElixir.Repo.Migrations.CreateChat do
  use Ecto.Migration

  def change do
    create table(:chats, primary_key: false) do
      add :book_id,    :integer, primary_key: true
      add :part_id,    :integer, primary_key: true
      add :section_id, :integer, primary_key: true
      add :chat_id,    :integer, primary_key: true
      add :channel_id, :integer
      add :potof_id,   :integer
      add :user_id,    references(:users, on_delete: :nothing)
      add :to,    :string
      add :style, :string
      add :log,   :string

      timestamps()
    end
    create index(:chats, [:book_id, :part_id, :section_id])
  end
end
