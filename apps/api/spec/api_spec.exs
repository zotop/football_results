defmodule ApiSpec do
  use ESpec
  use Plug.Test

  @opts Api.init([])
  
  context "when listing in JSON" do

    let division_1_2015_2016_barcelona: %{division: "SP1", season: "201516", home_team: "Barcelona"}
    let division_1_2015_2016_valladolid: %{division: "SP1", season: "201516", home_team: "Valladolid"}
    let division_1_2016_2017_barcelona: %{division: "SP1", season: "201617", home_team: "Granada"}
    let results: [division_1_2015_2016_barcelona(),
                  division_1_2015_2016_valladolid(),
                  division_1_2016_2017_barcelona()]
    let! inserted_results: FootballResults.Repo.insert_all(Database.Result, results())

    context "division and season pairs for which there are results" do

      it "should return unique division and season pairs" do
        conn = conn(:get, "/api/divisions_by_season")
        |> put_req_header("content-type", "application/json")
        |> Api.call(@opts)
        pairs = Poison.decode!(conn.resp_body)
        divisions = Enum.map(pairs, fn pair -> pair["division"] end)
        seasons = Enum.map(pairs, fn pair -> pair["season"] end)

        expect(length(pairs)).to eq(2)
        expect(divisions).to contain_exactly(["SP1", "SP1"])
        expect(seasons).to contain_exactly(["201617", "201516"])
      end

    end

  end

end
