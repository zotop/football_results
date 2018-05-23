use Mix.Config

config :database, ecto_repos: [FootballResults.Repo]

config :database, FootballResults.Repo,
        adapter: Ecto.Adapters.Postgres,
        database: "football_results_repo",
        username: System.get_env("DB_USER"),
        password: System.get_env("DB_PASSWORD"),
        hostname: System.get_env("DB_HOSTNAME")

config :logger,
        level: :info


import_config "#{Mix.env()}.exs"
