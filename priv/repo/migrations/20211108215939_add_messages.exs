defmodule PhoenixChatLive.Repo.Migrations.AddMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add(:author, :string, null: false)
      add(:text, :string, null: false)
      add(:chat_id, references(:chats))

      timestamps()
    end
  end
end
