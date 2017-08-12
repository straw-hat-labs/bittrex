defmodule Bittrex.Interactor.Market.GetMarkets do
  use Bittrex.Interactor
  alias Bittrex.Market

  def call do
    HttpRequest.new(:get, "/public/getmarkets")
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    result
    |> Enum.map(&Market.new/1)
  end
  defp format_response({:error, _result}), do: []
end
