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

## Seed Data

Multiple results will be seeded when running:
```
  docker-compose run app mix run apps/database/priv/repo/seeds/results.exs
```

`results.exs` is responsible for parsing the football(aka soccer) results present
in `data.csv` and inserting them in the database.

There are 2370 results present in `data.csv`.

## Generating ExDoc documentation

```
  mix docs
```  

Will generate html documentation. See /doc folder under each app.
