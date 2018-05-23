FROM elixir:1.6.5
ADD . /app
WORKDIR /app
EXPOSE 4001
ENV MIX_ENV=dev
RUN mix local.hex --force
RUN mix deps.get
RUN mix compile
CMD mix run --no-halt
