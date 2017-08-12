defmodule Bittrex.Interactor.Market.BuyLimit do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Order

  def call(market_name, quantity, rate) do
    params = [
      market: market_name,
      quantity: quantity,
      rate: rate
    ]

    HttpRequest.new(:get, "/market/buylimit", params)
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    Order.new(result)
  end
  defp format_response({:error, message}), do: {:error, message}
end
