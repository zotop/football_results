# FootballResults

## Running the application

```
  docker-compose build
  docker-compose up -d
  docker-compose run app mix ecto.create
  docker-compose run app mix ecto.migrate
  docker-compose run app mix run apps/database/priv/repo/seeds/results.exs
  docker-compose scale app=3
```
