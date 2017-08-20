defmodule Bittrex.Interactor.Account.GetOrder do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Order

  def call(id) do
    :get
    |> HttpRequest.new("/account/getorder", [uuid: id])
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    response = Order.new(result)
    {:ok, response}
  end
  defp format_response({:error, message}), do: {:error, message}
end
