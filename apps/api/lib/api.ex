defmodule Api do
  use Plug.Router
  require Database

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
    send_resp(conn, 200, Poison.encode!(results))
  end

  match _ do
    send_resp(conn, 404, "")
  end

end
