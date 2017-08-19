defmodule Bittrex.Interactor.Account.Withdraw do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Payment

  def call(currency, quantity, address, paymentid) do
    params = [
      currency: currency,
      quantity: quantity,
      address: address,
      paymentid: paymentid
    ]

    :get
    |> HttpRequest.new("/account/withdraw", params)
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    response = Payment.new(result)
    {:ok, response}
  end
  defp format_response({:error, message}), do: {:error, message}
end
