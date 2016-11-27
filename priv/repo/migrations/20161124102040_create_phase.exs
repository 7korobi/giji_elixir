defmodule Giji.Repo.Migrations.CreatePhase do
  use Ecto.Migration

  def change do
    create table(:phases, primary_key: false) do
      add :book_id,    :integer, primary_key: true
      add :part_id,    :integer, primary_key: true
      add :phase_id,   :integer, primary_key: true
      add :user_id,    references(:users, on_delete: :nothing)
      add :chat_id,    :integer
      add :name, :string

      timestamps()
      add :msec_at, :'bigint(20) not null'
    end
    create index(:phases, [:book_id, :part_id])
    create index(:phases, [:msec_at])
  end
end

