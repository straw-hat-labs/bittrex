defmodule Bittrex.Interactor.Market.GetMarketHistory do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.MarketHistory

  def call(market_name) do
    :get
    |> HttpRequest.new("/public/getmarkethistory", market: market_name)
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    response = Enum.map(result, &MarketHistory.new/1)
    {:ok, response}
  end

  defp format_response({:error, message}), do: {:error, message}
end
