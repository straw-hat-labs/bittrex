defmodule Bittrex.Interactor.OrderBook.GetOrderBook do
  use Bittrex.Interactor
  alias Bittrex.{OrderBook}

  def call(market_name, type) do
    params = [
      market: market_name,
      type: type]

    HttpRequest.new(:get, "/public/getorderbook", params)
    |> Client.send()
    |> format_response(type)
  end

  defp format_response({:ok, result}, "buy"),
    do: OrderBook.new(result, [])
  defp format_response({:ok, result}, "sell"),
    do: OrderBook.new([], result)
  defp format_response({:ok, result}, _type),
    do: OrderBook.new(result["buy"], result["sell"])
  defp format_response({:error, _result}, _type),
    do: []
end
