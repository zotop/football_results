ESpec.configure fn(config) ->

  Ecto.Adapters.SQL.Sandbox.mode(FootballResults.Repo, :manual)

  config.before fn() ->
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(FootballResults.Repo)
  end

  config.finally fn(_shared) ->
     Ecto.Adapters.SQL.Sandbox.checkin(FootballResults.Repo, [])
  end
end
