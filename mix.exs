defmodule Bittrex.Mixfile do
  use Mix.Project

  @elixir_version "~> 1.5"
  @name :bittrex
  @version "0.5.2"
  @description """
    Client for Bittrex (https://bittrex.com)
  """
  @source_url "https://github.com/straw-hat-llc/elixir_bittrex"

  def project do
    production? = Mix.env == :prod

    [
      app: @name,
      description: @description,
      version: @version,
      elixir: @elixir_version,
      build_embedded: production?,
      start_permanent: production?,
      deps: deps(),
      package: package(),

      # docs
      name: "Bittrex",
      source_url: @source_url,
      homepage_url: @source_url,
      docs: [
        main: "Bittrex",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpoison, "~> 0.12"},

      # Tools
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
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
end
