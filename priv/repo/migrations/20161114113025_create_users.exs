defmodule GijiElixir.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_id, :string
      add :name, :string
      add :avatar, :string
      timestamps()
    end
  end
end
