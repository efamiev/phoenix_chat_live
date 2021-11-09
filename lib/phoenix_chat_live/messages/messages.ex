defmodule PhoenixChatLive.Messages do
  alias PhoenixChatLive.Repo
  alias PhoenixChatLive.Message

  def create_message(attrs) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
    |> broadcast_change([:message, :created])
  end

  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
    |> broadcast_change([:message, :updated])
  end

  defp broadcast_change({:ok, message}, event) do
    Phoenix.PubSub.broadcast(
      PhoenixChatLive.PubSub,
      "chats:#{message.chat_id}",
      {event, message}
    )

    {:ok, message}
  end

  defp broadcast_change(result, _event) do
    result
  end
end
