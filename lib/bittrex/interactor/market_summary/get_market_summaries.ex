defmodule Bittrex.Interactor.MarketSummary.GetMarketSummaries do
  use Bittrex.Interactor
  alias Bittrex.MarketSummary

  def call do
    HttpRequest.new(:get, "/public/getmarketsummaries")
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    result
    |> Enum.map(&MarketSummary.new/1)
  end
  defp format_response({:error, message}), do: {:error, message}
end
