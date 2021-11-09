defmodule PhoenixChatLive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    credentials =
      "GOOGLE_APPLICATION_CREDENTIALS" |> System.fetch_env!() |> File.read!() |> Jason.decode!()

    source = {:service_account, credentials, []}

    children = [
      # Start the Telemetry supervisor
      PhoenixChatLiveWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixChatLive.PubSub},
      # Start the Endpoint (http/https)
      PhoenixChatLiveWeb.Endpoint,
      {Goth, name: PhoenixChatLive.Goth, source: source},
      {PhoenixChatLive.Repo, []}
      # Start a worker by calling: PhoenixChatLive.Worker.start_link(arg)
      # {PhoenixChatLive.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixChatLive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhoenixChatLiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
