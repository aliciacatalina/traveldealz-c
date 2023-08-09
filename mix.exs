defmodule DEALZ.MixProject do
  use Mix.Project

  def project do
    [
      app: :dealz,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: { Dealz.Application, [] },
      extra_applications: [:logger, :bamboo, :bamboo_smtp, :observer, :wx]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:crawly, "~> 0.13.0"},
      {:floki, "~> 0.26.0"},
      {:bamboo, "~> 2.2.0"},
      {:bamboo_smtp, "~> 4.2.2"},
      {:quantum, ">= 2.2.1"},
    ]
  end
end
