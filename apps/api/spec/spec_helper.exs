ESpec.configure fn(config) ->
  config.before fn() ->
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(FootballResults.Repo)
  end

  config.finally fn(_shared) ->
    Ecto.Adapters.SQL.Sandbox.checkin(FootballResults.Repo, [])
  end
end
