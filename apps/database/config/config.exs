use Mix.Config

config :database, ecto_repos: [FootballResults.Repo]

config :database, FootballResults.Repo,
        adapter: Ecto.Adapters.Postgres,
        database: "football_results_repo",
        username: "admin",
        password: "",
        hostname: "localhost"

config :logger,
        level: :info


import_config "#{Mix.env()}.exs"
