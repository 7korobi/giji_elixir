defmodule Giji.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :open_at,    :'bigint(20) not null'
      add :write_at,   :'bigint(20) not null'
      add :close_at,   :'bigint(20)'

      add :book_id,  :integer
      add :part_id,  :integer
      add :potof_id, references(:potofs, on_delete: :nothing)

      add :name, :string
      add :state, :integer
    end
    create index(:cards, [:book_id, :write_at])
  end
end
