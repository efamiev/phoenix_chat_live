use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_chat_live, PhoenixChatLiveWeb.Endpoint,
  http: [port: 4002],
  server: false

config :phoenix_chat_live, PhoenixChatLive.Repo,
  database: "phoenix_chat_live_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

# Print only warnings and errors during test
config :logger, level: :warn
