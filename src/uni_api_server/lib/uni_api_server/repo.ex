defmodule UniApiServer.Repo do
  use Ecto.Repo,
    otp_app: :uni_api_server,
    adapter: Ecto.Adapters.Postgres
end
