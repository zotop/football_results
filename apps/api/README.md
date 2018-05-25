# Api

Application responsible for serving the HTTP API.

## Endpoints

* GET `/api/divisions_by_season`: retrieval of all divisions + season pairs. Response is encoded in JSON.
* GET `/api/results`: retrieval of all results for the given division and season query parameters; for example GET ``/api/results?division=SP1&season=201516``.
If Accept request header is equal to `application/octet-stream`, then
will respond with encoded protobuf message, otherwise the response will
be JSON encoded. 

## Protobuf

Using [Exprotobuf](https://github.com/bitwalker/exprotobuf) for protobuf schemas definitions
and encoding/decoding of messages.

See `lib/proto/results.proto` for the schema definition of a football results message.

## Testing

Tests can be run with [espec](https://github.com/antonmi/espec)
via the command `mix espec`.

Note: Check and update accordingly `apps/database/config/test.exs`
for your test repository settings.
