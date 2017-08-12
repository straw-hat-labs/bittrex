defmodule Bittrex.Mixfile do
  use Mix.Project

  def project do
    [app: :bittrex,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:poison, "~> 3.1"},
     {:httpoison, "~> 0.12"}]
  end
end
