defmodule PhoenixChatLive.Message do
  use Ecto.Schema

  import Ecto.Changeset

  schema "messages" do
    field(:author)
    field(:text)
    belongs_to(:chat, PhoenixChatLive.Chat)

    timestamps()
  end

  def changeset(message, attrs \\ %{}) do
    message
    |> cast(attrs, [:author, :text, :chat_id])
  end
end
