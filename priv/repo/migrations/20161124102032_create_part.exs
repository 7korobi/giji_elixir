defmodule Giji.Repo.Migrations.CreatePart do
  use Ecto.Migration

  def change do
    create table(:parts, primary_key: false) do
      add :open_at,    :'bigint(20) not null'
      add :write_at,   :'bigint(20) not null'
      add :close_at,   :'bigint(20)'

      add :book_id, :integer, primary_key: true
      add :part_id, :integer, primary_key: true
      add :user_id, references(:users, on_delete: :nothing)
      add :section_id, :integer

      add :name, :string
    end
    create index(:parts, [:book_id, :write_at])
  end
end
