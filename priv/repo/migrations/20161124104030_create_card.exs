defmodule GijiElixir.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :book_id,  :integer
      add :part_id,  :integer
      add :potof_id, :integer
      add :name, :string
      add :state, :integer

      timestamps()
    end
    create index(:cards, [:book_id, :part_id])
    create index(:cards, [:potof_id])
  end
end
