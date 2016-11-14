defmodule GijiElixir.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :user_id, references(:users)
      add :face_id, :string
      add :query, :integer
      add :style, :string
      add :logid, :string
      add :log, :string
      timestamps()
    end
  end
end
