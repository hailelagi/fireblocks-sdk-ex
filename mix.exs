defmodule Fireblocks.MixProject do
  use Mix.Project

  def project do
    [
      app: :fireblocks,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [
        tool: ExCoveralls,
        preferred_cli_env: [
          coveralls: :test,
          "coveralls.detail": :test,
          "coveralls.post": :test,
          "coveralls.html": :test
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :crypto],
      mod: {Fireblocks.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "~> 0.10"},
      {:jason, "~> 1.3"},
      {:observer_cli, "~> 1.7"},
      {:telemetry, "~> 1.0"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:tesla, "~> 1.4"},
      {:joken, "~> 2.5"},
      { :uuid, "~> 1.1" },
      {:mox, "~> 1.0", only: :test},
      {:excoveralls, "~> 0.14", only: :test},
      {:faker, "~> 0.16", only: :test},
      {:credo, "~> 1.5", runtime: false}
    ]
  end
end
