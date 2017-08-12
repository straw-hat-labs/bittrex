defmodule Bittrex.Interactor.MarketSummary.GetMarketSummaries do
  use Bittrex.Interactor
  alias Bittrex.{HourStatus, Quote, Market, MarketSummary}

  def call do
    HttpRequest.new(:get, "/public/getmarketsummaries")
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    result
    |> Enum.map(&format_response_item/1)
  end
  defp format_response({:error, _result}), do: []

  defp format_response_item(item) do
    # TODO: add fields on
    # item["BaseVolume"]
    # item["TimeStamp"]
    # item["PrevDay"]

    market = %Market{
      name: item["MarketName"],
      display_name: item["DisplayMarketName"],
      volume: item["Volume"]
    }

    %MarketSummary{
      market: market,
      created_at: Bittrex.format_datetime(item["Created"]),
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
