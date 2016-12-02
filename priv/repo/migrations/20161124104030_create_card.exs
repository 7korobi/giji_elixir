defmodule Giji.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :open_at,    :'bigint(20) not null'
      add :write_at,   :'bigint(20) not null'
      add :close_at,   :'bigint(20)'

      add :potof_id, references(:potofs, on_delete: :nothing)
      add :part_id, references(:parts, on_delete: :nothing, type: :"varchar(8)")
      add :book_id, references(:books, on_delete: :delete_all, type: :"varchar(5)")

      add :name, :string
      add :state, :integer
    end
    create index(:cards, [:book_id, :write_at])
  end
end
