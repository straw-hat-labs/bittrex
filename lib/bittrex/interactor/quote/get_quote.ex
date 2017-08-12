defmodule Bittrex.Interactor.Quote.GetQuote do
  use Bittrex.Interactor
  alias Bittrex.Quote

  def call(market_name) do
    HttpRequest.new(:get, "/public/getticker", [market: market_name])
    |> Client.send()
    |> format_response(market_name)
  end

  defp format_response({:ok, result}, market_name),
    do: Quote.new(market_name, result)
  defp format_response({:error, _result}, _market_name),
    do: nil
end
