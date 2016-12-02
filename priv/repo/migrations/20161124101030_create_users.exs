defmodule Giji.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :open_at,    :'bigint(20) not null'
      add :write_at,   :'bigint(20) not null'
      add :close_at,   :'bigint(20)'

      add :provider, :string
      add :auth, :string
      add :name, :string
      add :avatar, :string
    end
  end
end
