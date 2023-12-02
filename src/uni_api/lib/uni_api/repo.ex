defmodule UniApi.Repo do
  use Ecto.Repo,
    otp_app: :uni_api,
    adapter: Ecto.Adapters.Postgres
end
