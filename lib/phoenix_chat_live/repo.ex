defmodule PhoenixChatLive.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_chat_live,
    adapter: Ecto.Adapters.Postgres
end
