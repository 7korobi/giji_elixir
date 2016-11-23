defmodule GijiElixir.Repo.Migrations.CreateSection do
  use Ecto.Migration

  def change do
    create table(:sections, primary_key: false) do
      add :book_id,    :integer, primary_key: true
      add :part_id,    :integer, primary_key: true
      add :section_id, :integer, primary_key: true
      add :user_id,    references(:users, on_delete: :nothing)
      add :name, :string

      timestamps()
    end
    create index(:sections, [:book_id, :part_id])

  end
end
