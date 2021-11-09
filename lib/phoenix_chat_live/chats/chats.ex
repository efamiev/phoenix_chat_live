defmodule PhoenixChatLive.Chats do
  import Ecto.Query
  alias PhoenixChatLive.Repo
  alias PhoenixChatLive.Chat
  alias PhoenixChatLive.Message

  def create_chat(attrs) do
    %Chat{}
    |> Chat.changeset(attrs)
    |> Repo.insert()
  end

  def chat_by_title(title) do
    Repo.get_by(Chat, title: title)
  end

  def chat_messages_list(%Chat{} = chat) do
    query =
      from(m in Message,
        where: m.chat_id == ^chat.id
      )

    Repo.all(query, preload: [:messages])
  end

  def subscribe(chat_id) do
    Phoenix.PubSub.subscribe(PhoenixChatLive.PubSub, "chats:#{chat_id}")
  end
end
