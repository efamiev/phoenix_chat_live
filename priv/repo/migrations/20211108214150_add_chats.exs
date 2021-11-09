defmodule PhoenixChatLive.Repo.Migrations.AddChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add(:title, :string, null: false)
    end

    create unique_index(:chats, [:title])
  end
end
