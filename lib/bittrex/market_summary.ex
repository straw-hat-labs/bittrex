defmodule Bittrex.MarketSummary do
  alias Bittrex.Interactor.MarketSummary.{GetMarketSummaries}

  defstruct [:created_at, :market, :quote, :last_hour_status, :orders_status]

  def get_market_summaries do
    GetMarketSummaries.call()
  end
end
