defmodule DatabaseSpec do
use ESpec

  context "when listing" do

    let division_1_2015_2016_barcelona: %{division: "SP1", season: "201516", home_team: "Barcelona"}
    let division_1_2015_2016_valladolid: %{division: "SP1", season: "201516", home_team: "Valladolid"}
    let division_1_2016_2017_barcelona: %{division: "SP1", season: "201617", home_team: "Granada"}
    let results: [division_1_2015_2016_barcelona(),
                  division_1_2015_2016_valladolid(),
                  division_1_2016_2017_barcelona()]
    let! inserted_results: FootballResults.Repo.insert_all(Database.Result, results())

    context "division and season pairs for which there are results" do

      it "should return unique division and season pairs" do
        division_season_pairs = Database.list_division_and_season_pairs()
        divisions = Enum.map(division_season_pairs, fn division_season_pair -> division_season_pair.division end)
        seasons = Enum.map(division_season_pairs, fn division_season_pair -> division_season_pair.season end)

        expect(length(division_season_pairs)).to be(2)
        expect(divisions).to contain_exactly(["SP1", "SP1"])
        expect(seasons).to contain_exactly(["201617", "201516"])
      end

    end

    context "results for a specific division and season pair" do

      it "should return the correct results" do
        results = Database.list_results(division: "SP1", season: "201516")
        seasons = Enum.map(results, fn result -> result.season end)
        home_teams = Enum.map(results, fn result -> result.home_team end)

        expect(length(results)).to be(2)
        expect(seasons).to contain_exactly(["201516", "201516"])
        expect(home_teams).to contain_exactly(["Valladolid", "Barcelona"])
      end

    end

  end

end
