defmodule Bittrex.Interactor.Account.GetOrderHistory do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Order

  def call(market_name) do
    :get
    |> HttpRequest.new("/account/getorderhistory", [market: market_name])
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    response = Enum.map(result, &Order.new/1)
    {:ok, response}
  end
  defp format_response({:error, message}), do: {:error, message}
end
