defmodule GijiElixir.Repo.Migrations.CreatePart do
  use Ecto.Migration

  def change do
    create table(:parts, primary_key: false) do
      add :book_id, :integer, primary_key: true
      add :part_id, :integer, primary_key: true
      add :user_id, references(:users, on_delete: :nothing)
      add :section_id, :integer
      add :name, :string

      timestamps()
    end
    create index(:parts, [:book_id])
  end
end
