# FootballResults

Elixir umbrella application containing 2 applications:

* Api: Application serving the HTTP API via [Plug](https://github.com/elixir-plug/plug)
and using [Cowboy](https://github.com/ninenines/cowboy) webserver.
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

You can now test the HTTP Api; see api application's [README](https://github.com/zotop/football_results/tree/master/apps/api#endpoints)

## Docker Compose Configuration

There are 3 services available:

* postgres: postgres docker image that contains the postgres database that stores the football results.
* app: HTTP api application that depends on postgres service. 
* haproxy: haproxy docker image that is used for handling load balancing for the app service. 
Serves the HTTP api on port 80

`docker-compose scale app=3` scales the app to 3 instances.

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
