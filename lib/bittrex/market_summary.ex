defmodule Bittrex.MarketSummary do
  alias Bittrex.{HourStatus, Quote, Market, MarketSummary}
  alias Bittrex.Interactor.MarketSummary.{
    GetMarketSummaries, GetMarketSummary
  }

  defstruct [:created_at, :market, :quote, :last_hour_status, :orders_status,
             :previous_day]

  def get_market_summaries do
    GetMarketSummaries.call()
  end

  def get_market_summary(market_name) do
    GetMarketSummary.call(market_name)
  end

  def new(item) do
    market = %Market{
      name: item["MarketName"],
      display_name: item["DisplayMarketName"],
      volume: item["Volume"]
    }

    %MarketSummary{
      market: market,
      created_at: Bittrex.format_datetime(item["Created"]),
      previous_day: item["PrevDay"],
      last_hour_status: %HourStatus{
        lowest: item["Low"],
        highest: item["High"],
      },
      quote: %Quote{
        market: market,
        bid: item["Bid"],
        ask: item["Ask"],
        last: item["Last"]
      },
      orders_status: %{
        buy: item["OpenBuyOrders"],
        sell: item["OpenSellOrders"]
      }
    }
  end
end
