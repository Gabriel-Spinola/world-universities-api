import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :world_uni_api_server, WorldUniApiServer.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "world_uni_api_server_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :world_uni_api_server, WorldUniApiServerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "y0GWQqYHQP15gV5sJHpaKPT/psHbf1FSOTK7HeSwpSvu2RBFcDEZnRkmq6aybiuZ",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
