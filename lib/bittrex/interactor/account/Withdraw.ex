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

    HttpRequest.new(:get, "/account/withdraw", params)
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    Payment.new(result)
  end
  defp format_response({:error, message}), do: {:error, message}
end
