defmodule Bittrex.Quote do
  @moduledoc """
  Quote use cases.
  """

  alias Bittrex.{Quote, Market}
  alias Bittrex.Interactor.Quote.{GetQuote}

  defstruct [:market, :bid, :ask, :last]

  def get_quote(market_name) do
    GetQuote.call(market_name)
  end

  def new(market_name, item) when is_binary(market_name) do
    %Market{name: market_name} |> new(item)
  end

  def new(market, item) do
    %Quote{
      market: market,
      bid: item["Bid"],
      ask: item["Ask"],
      last: item["Last"]
    }
  end
end
