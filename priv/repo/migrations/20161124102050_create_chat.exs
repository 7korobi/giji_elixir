defmodule Giji.Repo.Migrations.CreateChat do
  use Ecto.Migration

  def change do
    create table(:chats, primary_key: false) do
      add :open_at,    :'bigint(20) not null'
      add :write_at,   :'bigint(20) not null'
      add :close_at,   :'bigint(20)'

      add :book_id,  :integer, primary_key: true
      add :part_id,  :integer, primary_key: true
      add :phase_id, :integer, primary_key: true
      add :chat_id,  :integer, primary_key: true
      add :user_id,  references(:users, on_delete: :nothing)
      add :section_id, :integer
      add :potof_id,   :integer

      add :to,    :string
      add :style, :string
      add :log,   :'text not null'
    end
    create index(:chats, [:book_id, :part_id, :section_id])
    create index(:chats, [:book_id, :write_at])
  end
end