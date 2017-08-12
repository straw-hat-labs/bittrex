defmodule Bittrex.Interactor.Market.GetMarkets do
  use Bittrex.Interactor

  alias Bittrex.Market
  alias Bittrex.Currency

  def call do
    HttpRequest.new(:get, "/public/getmarkets")
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    result
    |> Enum.map(&format_response_item/1)
  end
  defp format_response({:error, _result}), do: []

  defp format_response_item(item) do
    %Market{
      name: item["MarketName"],
      minimum_trade: item["MinTradeSize"],
      active: item["IsActive"],
      created_at: Bittrex.format_datetime(item["Created"]),
      base_currency: %Currency{
        code: item["BaseCurrency"],
        name: item["BaseCurrencyLong"]
      },
      market_currency: %Currency{
        code: item["MarketCurrency"],
        name: item["MarketCurrencyLong"]
      }
    }
  end
end
