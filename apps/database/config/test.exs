use Mix.Config

config :database, FootballResults.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "test_football_results_repo",
  hostname: "localhost",
  username: "admin",
  password: "",
  pool: Ecto.Adapters.SQL.Sandbox
