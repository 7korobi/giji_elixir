defmodule GijiElixir.Repo.Migrations.CreatePotof do
  use Ecto.Migration

  def change do
    create table(:potofs) do
      add :book_id,    :integer
      add :part_id,    :integer
      add :section_id, :integer
      add :user_id,    references(:users, on_delete: :nothing)
      add :name,    :string
      add :job,     :string
      add :sign,    :string
      add :face_id, :string
      add :state,   :integer

      timestamps()
    end
    create index(:potofs, [:book_id, :part_id, :section_id])
  end
end
