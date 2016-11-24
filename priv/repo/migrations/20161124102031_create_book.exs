defmodule Giji.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :book_id, :integer, primary_key: true
      add :user_id, references(:users, on_delete: :nothing)
      add :part_id, :integer
      add :name, :string

      timestamps()
    end
  end
end
