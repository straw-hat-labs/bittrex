defmodule Bittrex.Interactor.Order.CancelOrder do
  @moduledoc false

  use Bittrex.Interactor

  def call(order_id) do
    HttpRequest.new(:get, "/market/cancel", [uuid: order_id])
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, _result}), do: {:ok, true}
  defp format_response({:error, message}), do: {:error, message}
end
