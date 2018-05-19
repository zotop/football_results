
string_to_int = fn (string) ->
  elem(Integer.parse(string), 0)
end

map_result = fn (row) ->
  {:ok, row} = row
  row = Map.delete(row, "")
  [day, month, year] = String.split(row[:date], "/")
  year = "20" <> year
  formatted_date = Enum.join([year, month, day], "-")
  row = Map.put(row, :date, Ecto.Date.cast!(formatted_date))
  row = Map.put(row, :ftag, string_to_int.(row[:ftag]))
  row = Map.put(row, :fthg, string_to_int.(row[:fthg]))
  row = Map.put(row, :htag, string_to_int.(row[:htag]))
  row = Map.put(row, :hthg, string_to_int.(row[:hthg]))
  row
end

IO.puts "Starting to seed the football results..."
rows = File.stream!(Path.expand("./priv/repo/seeds/data.csv"))
|> Stream.drop(1)
|> CSV.decode(headers: ["", :division, :season, :date, :home_team, :away_team,
                        :fthg, :ftag, :ftr, :hthg, :htag, :htr])
|> Enum.map(fn (row) -> map_result.(row) end)

results_count = elem(FootballResults.Repo.insert_all(Database.Result, rows), 0)
IO.puts "Done! Seeded #{results_count} results."
