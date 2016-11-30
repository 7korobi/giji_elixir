defmodule Giji.Repo.Migrations.CreateSection do
  use Ecto.Migration

  def change do
    create table(:sections, primary_key: false) do
      add :open_at,    :'bigint(20) not null'
      add :write_at,   :'bigint(20) not null'
      add :close_at,   :'bigint(20)'

      add :book_id,    :integer, primary_key: true
      add :part_id,    :integer, primary_key: true
      add :section_id, :integer, primary_key: true
      add :user_id,    references(:users, on_delete: :nothing)

      add :name, :string
    end
    create index(:sections, [:book_id, :part_id])
    create index(:sections, [:book_id, :write_at])
  end
end