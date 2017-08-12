defmodule Bittrex.Interactor.Quote.GetQuote do
  use Bittrex.Interactor
  alias Bittrex.{Quote, Market}

  def call(market) do
    HttpRequest.new(:get, "/public/getticker", [market: market])
    |> Client.send()
    |> format_response(market)
  end

  defp format_response({:ok, result}, market) do
    %Quote{
      market: %Market{name: market},
      bid: result["Bid"],
      ask: result["Ask"],
      last: result["Last"]
    }
  end
  defp format_response({:error, result}, _), do: nil
end
