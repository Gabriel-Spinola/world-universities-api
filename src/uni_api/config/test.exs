import Config

config :uni_api, UniApi.Repo,
  database: "uni_api_repo",
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  hostname: "localhost"

config :uni_api, UniApiTest.RouterTest, http: [port: 8080]
config :ex_unit, colors: Mix.env() == :test
