use Mix.Config

config :database, FootballResults.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "test_football_results_repo",
  username: System.get_env("DB_USER"),
  password: System.get_env("DB_PASSWORD"),
  hostname: System.get_env("DB_HOSTNAME")
  pool: Ecto.Adapters.SQL.Sandbox
