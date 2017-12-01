defmodule Bittrex.Interactor.MarketSummary.GetMarketSummary do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.MarketSummary

  def call(market_name) do
    :get
    |> HttpRequest.new("/public/getmarketsummary", market: market_name)
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    response =
      result
      |> List.first()
      |> MarketSummary.new()

    {:ok, response}
  end

  defp format_response({:error, message}), do: {:error, message}
end
