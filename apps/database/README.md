# Database

Application responsible for database communication, which contains:

* Wrapper for querying the Postgres database using [Ecto](https://github.com/elixir-ecto/ecto).
* Seed data which consists of 2370 football results present in data.csv.

## Ecto - Mix Tasks

* `mix ecto.create`: creates the storage for the given repository.
* `mix ecto.create`: runs the pending migrations for the given repository.

## Testing

Tests can be run with [espec](https://github.com/antonmi/espec)
via the command `mix espec`.

Note: Check and update accordingly `/config/test.exs`
for your test repository settings.
