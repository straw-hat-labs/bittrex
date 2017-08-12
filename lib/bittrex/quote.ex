defmodule Bittrex.Quote do
  alias Bittrex.Interactor.Quote.{GetQuote}

  defstruct [:market, :bid, :ask, :last]

  def get_quote(market_name) do
    GetQuote.call(market_name)
  end
end
