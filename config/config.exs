# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix_chat_live,
  ecto_repos: [PhoenixChatLive.Repo]

# config :phoenix_chat_live, PhoenixChatLive.Repo,
#   database: "phoenix_chat_live_repo",
#   username: "user",
#   password: "pass",
#   hostname: "localhost"

# Configures the endpoint
config :phoenix_chat_live, PhoenixChatLiveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cTOkMA779yJfco1Mobwzh3ZI6/rUInVbPVySGx7NSq3v1xIaF3MM+LLbdchgSJW4",
  render_errors: [view: PhoenixChatLiveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhoenixChatLive.PubSub,
  live_view: [signing_salt: "oW/21DN1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
