defmodule Giji.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :book_id,  :integer
      add :part_id,  :integer
      add :potof_id, references(:potofs, on_delete: :nothing)

      add :name, :string
      add :state, :integer

      timestamps()
      add :msec_at, :'bigint(20) not null'
    end
    create index(:cards, [:book_id, :part_id])
    create index(:cards, [:potof_id])
    create index(:cards, [:msec_at])
  end
end
