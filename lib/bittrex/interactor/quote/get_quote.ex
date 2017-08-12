defmodule Bittrex.Interactor.Quote.GetQuote do
  use Bittrex.Interactor
  alias Bittrex.{Quote, Market}

  def call(market_name) do
    HttpRequest.new(:get, "/public/getticker", [market: market_name])
    |> Client.send()
    |> format_response(market_name)
  end

  defp format_response({:ok, result}, market_name) do
    %Quote{
      market: %Market{name: market_name},
      bid: result["Bid"],
      ask: result["Ask"],
      last: result["Last"]
    }
  end
  defp format_response({:error, _result}, _), do: nil
end
