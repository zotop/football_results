defmodule Api do
  @moduledoc """
  API endpoints definitions

  ## GET /api/divisions_by_season
     Retrieval of all divisions + season pairs.
     Response is encoded in JSON.

  ## GET /api/results
     Retrieval of all results for the given division and season query parameters.

     If Accept request header is equal to "application/octet-stream", then
     will respond with encoded protobuf message, otherwise the response will
     be JSON encoded.

  ## Example

    /api/results?division=SP1&season=201516

  """
  use Plug.Router
  import Plug.Conn
  require Database
  require Protobufs

  plug :match
  plug :dispatch

  get "/api/divisions_by_season" do
    pairs = Database.list_division_and_season_pairs()
    send_resp(conn, 200, Poison.encode!(pairs))
  end

  get "/api/results" do
    conn = fetch_query_params(conn)
    %{"division" => division, "season" => season} = conn.params
    results = Database.list_results(division: division, season: season)

    [accept_header] = Plug.Conn.get_req_header(conn, "accept")
    if accept_header == "application/octet-stream" do
      results = Enum.map(results, fn result -> Map.from_struct(result) |> Enum.filter(fn {_, v} -> v != nil end) end)
      results = Enum.map(results, fn result -> Map.new(result) |> Map.put(:date, Date.to_string(result[:date])) end)
      results = Enum.map(results, fn result -> Protobufs.Result.new(result)  end)
      results = Protobufs.Results.new(results: results)
      encoded_results = Protobufs.Results.encode(results)
      send_resp(conn, 200, encoded_results)
    else #respond with json
      send_resp(conn, 200, Poison.encode!(results))
    end

  end

  match _ do
    send_resp(conn, 404, "")
  end

end
