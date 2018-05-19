defmodule Database.MixProject do
  use Mix.Project

  def project do
    [
      app: :database,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Database.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:postgrex, ">= 0.11.1"},
     {:ecto, "~> 2.0"},
     {:csv, "~> 2.0.0"}
    ]
  end
end
