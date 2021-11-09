defmodule PhoenixChatLiveWeb.ChatLive do
  use PhoenixChatLiveWeb, :live_view

  require Logger

  alias PhoenixChatLive.Chat
  alias PhoenixChatLive.Chats
  alias PhoenixChatLive.Messages

  @impl true
  def mount(%{"chat_name" => chat_name}, _session, socket) do
    case Chats.chat_by_title(chat_name) do
      %Chat{} = chat ->
        Chats.subscribe(chat.id)

        messages = Chats.chat_messages_list(chat)

        socket =
          socket
          |> assign(chat_name: chat_name)
          |> assign(chat: chat)
          |> assign(messages: messages)

        {:ok, socket}

      nil ->
        {:ok, assign(socket, chat_name: chat_name, chat: nil, messages: [])}
    end
  end

  @impl true
  def handle_event("send_message", %{"form" => %{"author" => author, "text" => text}}, %{assigns: %{chat: %Chat{id: id}}} = socket) do
    create_message(%{
      author: author,
      text: text,
      chat_id: id
    })

    {:noreply, socket}
  end

  def handle_event("send_message", %{"form" => %{"author" => author, "text" => text}}, socket) do
    case Chats.create_chat(%{title: socket.assigns.chat_name}) do
      {:ok, chat} ->
        Chats.subscribe(chat.id)

        create_message(%{
          author: author,
          text: text,
          chat_id: chat.id
        })

      {:error, reason} ->
        Logger.error("Create chat error #{inspect(reason)}")
        {:error, reason}
    end

    {:noreply, socket}
  end

  @impl true
  def handle_info({[:message, :created], message}, socket) do
    Task.start(fn -> PhoenixChatLive.TranslateTask.translate(message) end)

    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end

  def handle_info({[:message, :updated], translated_message}, socket) do
    messages =
      socket.assigns.messages
      |> Enum.drop(-1)
      |> Enum.concat([translated_message])

    {:noreply, assign(socket, messages: messages)}
  end

  defp create_message(attrs) do
    case Messages.create_message(attrs) do
      {:ok, message} ->
        {:ok, message}

      {:error, reason} ->
        Logger.error("Create message error #{inspect(reason)}")

        {:error, reason}
    end
  end
end
