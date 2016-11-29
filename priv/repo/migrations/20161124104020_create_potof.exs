defmodule Giji.Repo.Migrations.CreatePotof do
  use Ecto.Migration

  def change do
    create table(:potofs) do
      add :open_at,    :'bigint(20) not null'
      add :write_at,   :'bigint(20) not null'
      add :close_at,   :'bigint(20)'

      add :book_id,    :integer
      add :part_id,    :integer
      add :user_id,    references(:users, on_delete: :nothing)

      add :name,    :string
      add :job,     :string
      add :sign,    :string
      add :face_id, :string
      add :state,   :integer
    end
    create index(:potofs, [:book_id, :write_at])
  end
end
