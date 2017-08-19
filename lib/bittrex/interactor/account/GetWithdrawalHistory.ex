defmodule Bittrex.Interactor.Account.GetWithdrawalHistory do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Payment

  def call(currency) do
    HttpRequest.new(:get, "/account/getwithdrawalhistory", [currency: currency])
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    response = Enum.map(result, &Payment.new/1)
    {:ok, response}
  end
  defp format_response({:error, message}), do: {:error, message}
end
