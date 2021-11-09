# PhoenixChatLive

## Для запуск проекта

  * Установка зависимостей elixir `mix deps.get`
  * Установка зависимостей node.js `cd assets && npm i`
  * Подготовка postgres `mix ecto.setup`
  * Для работы с google api установите переменную среды\
    `export GOOGLE_APPLICATION_CREDENTIALS=path-to-json-credentials-file/phoenix_chat_live/translate-chat-331020-3308ee9fa4d5.json`
  * Запуск `mix phx.server`

Сервис будет доступен на [`localhost:4000`](http://localhost:4000).

## Функционал

  * Создайте чат, передя по [`localhost:4000/chats/first_chat`](http://localhost:4000/chats/first_chat)
  * Продублируйте вкладку с созданным чатом
  * Отправляйте сообщения
