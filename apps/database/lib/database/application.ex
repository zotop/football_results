defmodule Database.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      FootballResults.Repo
    ]

    Logger.info("Starting Database application")

    opts = [strategy: :one_for_one, name: Database.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
