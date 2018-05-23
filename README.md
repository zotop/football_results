# FootballResults

## Running the application

```
  docker-compose build
  docker-compose up -d postgres
  docker-compose run app mix ecto.create
  docker-compose run app mix run apps/database/priv/repo/seeds/results.exs
  docker-compose up 
```
