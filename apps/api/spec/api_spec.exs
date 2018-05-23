defmodule ApiSpec do
  use ESpec
  use Plug.Test

  @opts Api.init([])

  context "when listing" do

    let division_1_2015_2016_barcelona: %{division: "SP1", season: "201516",
                                          home_team: "Barcelona", date: Ecto.Date.cast!("2016-01-01")}
    let division_1_2015_2016_valladolid: %{division: "SP1", season: "201516",
                                          home_team: "Valladolid", date: Ecto.Date.cast!("2016-01-01")}
    let division_1_2016_2017_barcelona: %{division: "SP1", season: "201617",
                                          home_team: "Granada", date: Ecto.Date.cast!("2017-01-01")}
    let results: [division_1_2015_2016_barcelona(),
                  division_1_2015_2016_valladolid(),
                  division_1_2016_2017_barcelona()]
    let! inserted_results: FootballResults.Repo.insert_all(Database.Result, results())

    context "division and season pairs for which there are results" do

      it "should return unique division and season pairs" do
        conn = conn(:get, "/api/divisions_by_season")
        |> Api.call(@opts)
        pairs = Poison.decode!(conn.resp_body)
        divisions = Enum.map(pairs, fn pair -> pair["division"] end)
        seasons = Enum.map(pairs, fn pair -> pair["season"] end)

        expect(length(pairs)).to eq(2)
        expect(divisions).to contain_exactly(["SP1", "SP1"])
        expect(seasons).to contain_exactly(["201617", "201516"])
      end

    end

    context "results for a specific division and season pair" do

      context "in JSON format" do

        it "should return the correct results" do
          conn = conn(:get, "/api/results?division=SP1&season=201516")
          |> put_req_header("accept", "application/json")
          |> Api.call(@opts)
          results = Poison.decode!(conn.resp_body)
          divisions = Enum.map(results, fn result -> result["division"] end)
          seasons = Enum.map(results, fn result -> result["season"] end)
          home_teams = Enum.map(results, fn result -> result["home_team"] end)

          expect(length(results)).to be(2)
          expect(divisions).to contain_exactly(["SP1", "SP1"])
          expect(seasons).to contain_exactly(["201516", "201516"])
          expect(home_teams).to contain_exactly(["Valladolid", "Barcelona"])
        end

      end

      context "in encoded Protobuffer format" do

        it "should return the correct results" do
          conn = conn(:get, "/api/results?division=SP1&season=201516")
          |> put_req_header("accept", "application/octet-stream")
          |> Api.call(@opts)
          results = conn.resp_body
          decoded_results = Protobufs.Results.decode(results).results
          divisions = Enum.map(decoded_results, fn result -> result.division end)
          seasons = Enum.map(decoded_results, fn result -> result.season end)
          home_teams = Enum.map(decoded_results, fn result -> result.home_team end)

          expect(length(decoded_results)).to be(2)
          expect(divisions).to contain_exactly(["SP1", "SP1"])
          expect(seasons).to contain_exactly(["201516", "201516"])
          expect(home_teams).to contain_exactly(["Valladolid", "Barcelona"])
        end

      end

    end

  end

end
