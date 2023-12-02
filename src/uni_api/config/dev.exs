import Config

config :uni_api, UniApi.Repo,
  database: "uni_api_repo",
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  hostname: "localhost"
