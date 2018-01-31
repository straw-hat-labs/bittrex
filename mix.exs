defmodule Bittrex.Mixfile do
  use Mix.Project

  @name :bittrex
  @version "0.5.4"
  @elixir_version "~> 1.5"

  @description """
    Client for Bittrex (https://bittrex.com)
  """
  @source_url "https://github.com/straw-hat-team/bittrex"

  def project do
    [
      name: "Bittrex",
      description: @description,
      app: @name,
      version: @version,
      elixir: @elixir_version,
      deps: deps(),

      # Extras
      package: package(),
      docs: docs()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.0"},

      # Tools
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      name: @name,
      files: [
        "lib",
        "mix.exs",
        "README*",
        "LICENSE*"
      ],
      maintainers: ["Yordis Prieto"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      homepage_url: @source_url,
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end
end
