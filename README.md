# FootballResults

Elixir umbrella application containing 2 applications:

* Api: Plug application serving as the HTTP API.
* Database: Wrapper for querying the Postgres database using Ecto.

## Running the application

```
  docker-compose build
  docker-compose up -d
  docker-compose run app mix ecto.create
  docker-compose run app mix ecto.migrate
  docker-compose run app mix run apps/database/priv/repo/seeds/results.exs
  docker-compose scale app=3
```

## Generating ExDoc documentation

```
  mix docs
```  

Will generate html documentation. See /doc folder under each app.
