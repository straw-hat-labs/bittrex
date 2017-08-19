defmodule Bittrex.Interactor.Quote.GetQuote do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Quote

  def call(market_name) do
    :get
    |> HttpRequest.new("/public/getticker", [market: market_name])
    |> Client.send()
    |> format_response(market_name)
  end

  defp format_response({:ok, result}, market_name) do
    response = Quote.new(market_name, result)
    {:ok, response}
  end
  defp format_response({:error, message}, _market_name), do: {:error, message}
end
