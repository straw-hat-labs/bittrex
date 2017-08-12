defmodule Bittrex.Interactor.Market.GetMarketHistory do
  use Bittrex.Interactor
  alias Bittrex.Order

  def call(market_name) do
    HttpRequest.new(:get, "/public/getmarkethistory", [market: market_name])
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    result
    |> Enum.map(&Order.new/1)
  end
  defp format_response({:error, _result}), do: []
end
