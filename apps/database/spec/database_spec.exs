defmodule DatabaseSpec do
use ESpec

  context "when listing" do

    let division_1_2015_2016_barcelona: %{division: "SP1", season: "201516", home_team: "Barcelona"}
    let division_1_2015_2016_valladolid: %{division: "SP1", season: "201516", home_team: "Valladolid"}
    let division_1_2016_2017_barcelona: %{division: "SP1", season: "201617", home_team: "Barcelona"}
    let results: [division_1_2015_2016_barcelona(),
                  division_1_2015_2016_valladolid(),
                  division_1_2016_2017_barcelona()]

    context "division and season pairs for which there are results" do

      it "should return unique division and season pairs" do
        FootballResults.Repo.insert_all(Database.Result, results())
        division_season_pairs = Database.list_division_and_season_pairs()
        divisions = Enum.map(division_season_pairs, fn division_season_pair -> division_season_pair.division end)
        seasons = Enum.map(division_season_pairs, fn division_season_pair -> division_season_pair.season end)

        expect(length(division_season_pairs)).to be(2)
        expect(divisions).to contain_exactly(["SP1", "SP1"])
        expect(seasons).to contain_exactly(["201617", "201516"])
      end

    end

  end

end
