import Config

config :uni_api, ecto_repos: [UniApi.Repo]

import_config "#{config_env()}.exs"
