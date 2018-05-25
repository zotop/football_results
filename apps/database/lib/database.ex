defmodule Database do
  @moduledoc """
  Postgres Database wrapper
  """
import Ecto.Query, only: [from: 2]

  @doc """
  Returns a list of season and division(=league) pairs

  ## Parameters

    - none

  ## Examples

      iex> Database.list_division_and_season_pairs
      [
      %{division: "E0", season: "201617"},
      %{division: "SP1", season: "201516"},
      %{division: "SP2", season: "201617"},
      %{division: "SP2", season: "201516"},
      %{division: "SP1", season: "201617"},
      %{division: "D1", season: "201617"}
      ]

  """
  def list_division_and_season_pairs do
    FootballResults.Repo.all(from(result in Database.Result, distinct: true,
                             select: %{division: result.division, season: result.season}))
  end

  @doc """
  Returns a list of season and division(=league) pairs

  ## Parameters

    - division: String representing the league. Ex: "E0", "SP1", "SP2"
    - season: String representing the season. Ex: "201516", "201617"

  ## Examples

      iex> Database.list_results(division: ""E0", season: "201617")
      [
      %Database.Result{
          __meta__: #Ecto.Schema.Metadata<:loaded, "result">,
          away_team: "West Brom",
          date: ~D[2016-09-10],
          division: "E0",
          ftag: 0,
          fthg: 1,
          ftr: "H",
          home_team: "Bournemouth",
          htag: 0,
          hthg: 0,
          htr: "D",
          id: "eec577cb-2e5b-4453-a1db-98110dcc5e83",
          season: "201617"
      },
      %Database.Result{...},
      ...
      ]

  """
  def list_results(division: division, season: season) do
    FootballResults.Repo.all(from(result in Database.Result,
                             where: [division: ^division, season: ^season]))
  end
end
