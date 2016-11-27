defmodule Giji.Repo.Migrations.CreatePart do
  use Ecto.Migration

  def change do
    create table(:parts, primary_key: false) do
      add :book_id, :integer, primary_key: true
      add :part_id, :integer, primary_key: true
      add :user_id, references(:users, on_delete: :nothing)
      add :section_id, :integer
      add :name, :string

      timestamps()
      add :msec_at, :'bigint(20) not null'
    end
    create index(:parts, [:book_id])
    create index(:parts, [:msec_at])
  end
end
