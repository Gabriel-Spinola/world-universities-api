defmodule WorldUniApiServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WorldUniApiServerWeb.Telemetry,
      WorldUniApiServer.Repo,
      {DNSCluster, query: Application.get_env(:world_uni_api_server, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WorldUniApiServer.PubSub},
      # Start a worker by calling: WorldUniApiServer.Worker.start_link(arg)
      # {WorldUniApiServer.Worker, arg},
      # Start to serve requests, typically the last entry
      WorldUniApiServerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WorldUniApiServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WorldUniApiServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
