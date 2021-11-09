defmodule PhoenixChatLive.Chat do
  use Ecto.Schema

  import Ecto.Changeset

  schema "chats" do
    field(:title)
    has_many(:messages, PhoenixChatLive.Message)
  end

  def changeset(chat, attrs \\ %{}) do
    chat
    |> cast(attrs, [:title])
    |> unique_constraint(:title)
  end
end
