defmodule Giji.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :"varchar(5)", primary_key: true # 99999
      add :open_at,    :'bigint(20) not null'
      add :write_at,   :'bigint(20) not null'
      add :close_at,   :'bigint(20)'

      add :user_id, references(:users, on_delete: :nothing)
      add :part_idx, :integer

      add :name, :string
    end
  end
end
