defmodule Database do
import Ecto.Query, only: [from: 2]

  def list_division_and_season_pairs do
    FootballResults.Repo.all(from(result in Database.Result, distinct: true,
                             select: %{division: result.division, season: result.season}))
  end

  def list_results(division: division, season: season) do
    FootballResults.Repo.all(from(result in Database.Result,
                             where: [division: ^division, season: ^season]))                         
  end
end
