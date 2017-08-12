defmodule Bittrex.Quote do
  alias Bittrex.Interactor.Quote.{GetQuote}

  defstruct [:market, :bid, :ask, :last]

  def get_quote(market) do
    GetQuote.call(market)
  end
end
