defmodule Protobufs do
  @moduledoc """
  Module for accessing protobuf schema definitions
  """
  use Protobuf, from: Path.wildcard(Path.expand("./proto/*.proto", __DIR__))
end
