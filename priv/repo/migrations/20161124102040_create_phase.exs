defmodule Giji.Repo.Migrations.CreatePhase do
  use Ecto.Migration

  def change do
    create table(:phases, primary_key: false) do
      add :id, :"varchar(11)", primary_key: true # 99999-99-99
      add :open_at,    :'bigint(20) not null'
      add :write_at,   :'bigint(20) not null'
      add :close_at,   :'bigint(20)'

      add :user_id,    references(:users, on_delete: :nothing)
      add :book_id,    references(:books, on_delete: :delete_all, type: :"varchar(5)")
      add :chat_idx,   :integer

      add :name, :string
    end
    create index(:phases, [:book_id, :write_at])
  end
end

