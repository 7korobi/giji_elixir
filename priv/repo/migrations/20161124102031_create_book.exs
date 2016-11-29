defmodule Giji.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :open_at,    :'bigint(20) not null'
      add :write_at,   :'bigint(20) not null'
      add :close_at,   :'bigint(20)'

      add :book_id, :integer, primary_key: true
      add :user_id, references(:users, on_delete: :nothing)
      add :part_id, :integer

      add :name, :string
    end

    create index(:books, [:write_at])
  end
end
