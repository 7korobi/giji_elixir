defmodule Giji.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_id, :string
      add :name, :string
      add :avatar, :string

      timestamps
      add :msec_at, :'bigint(20) not null'
    end

    create index(:users, [:msec_at])
  end
end
