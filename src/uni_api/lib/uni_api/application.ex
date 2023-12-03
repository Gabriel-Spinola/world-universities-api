defmodule UniApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      UniApi.Repo,
      { Plug.Cowboy, scheme: :http, plug: UniApi.Router, options: [port: 8080] }
    ]

    opts = [strategy: :one_for_one, name: UniApi.Supervisor]
    Logger.info("Starting App...")
    Supervisor.start_link(children, opts)
  end
end
