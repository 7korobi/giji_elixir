defmodule GijiElixir.Repo.Migrations.CreateChannel do
  use Ecto.Migration

  def change do
    create table(:channels, primary_key: false) do
      add :book_id,    :integer, primary_key: true
      add :part_id,    :integer, primary_key: true
      add :channel_id, :integer, primary_key: true
      add :user_id,    references(:users, on_delete: :nothing)
      add :chat_id,    :integer
      add :name, :string

      timestamps()
    end
    create index(:channels, [:book_id, :part_id])
  end
end

