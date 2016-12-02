defmodule Giji.Repo.Migrations.CreateChat do
  use Ecto.Migration

  def change do
    create table(:chats, primary_key: false) do
      add :id, :"varchar(16)", primary_key: true # 99999-99-99-99999
      add :section_id, :"varchar(11)"            # 99999-99-99
      add :open_at,    :'bigint(20) not null'
      add :write_at,   :'bigint(20) not null'
      add :close_at,   :'bigint(20)'

      add :user_id,  references(:users,  on_delete: :nothing)
      add :potof_id, references(:potofs, on_delete: :nothing)

      add :to,    :string
      add :style, :string
      add :log,   :'text not null'
    end
    create index(:chats, [:section_id, :write_at])
  end
end
