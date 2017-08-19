defmodule Bittrex.Interactor.Account.GetOrderHistory do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Order

  def call(market_name) do
    HttpRequest.new(:get, "/account/getorderhistory", [market: market_name])
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    result
    |> Enum.map(&Order.new/1)
  end
  defp format_response({:error, message}), do: {:error, message}
end
