defmodule WorldUniApiServer.Repo do
  use Ecto.Repo,
    otp_app: :world_uni_api_server,
    adapter: Ecto.Adapters.Postgres
end
