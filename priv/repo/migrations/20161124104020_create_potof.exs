defmodule Giji.Repo.Migrations.CreatePotof do
  use Ecto.Migration

  def change do
    create table(:potofs) do
      add :book_id,    :integer
      add :part_id,    :integer
      add :user_id,    references(:users, on_delete: :nothing)
      add :name,    :string
      add :job,     :string
      add :sign,    :string
      add :face_id, :string
      add :state,   :integer

      timestamps()
      add :msec_at, :'bigint(20) not null'
    end
    create index(:potofs, [:book_id, :part_id])
    create index(:potofs, [:msec_at])
  end
end
