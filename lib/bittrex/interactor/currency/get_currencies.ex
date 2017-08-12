defmodule Bittrex.Interactor.Currency.GetCurrencies do
  use Bittrex.Interactor
  alias Bittrex.Currency

  def call do
    HttpRequest.new(:get, "/public/getcurrencies")
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    result
    |> Enum.map(&format_response_item/1)
  end
  defp format_response({:error, _result}), do: []

  defp format_response_item(item) do
    %Currency{
      code: item["Currency"],
      name: item["CurrencyLong"],
      active: item["IsActive"],
      transaction_fee: item["TxFee"],
      minimum_confirmation: item["MinConfirmation"],
      coin_type: item["CoinType"],
      base_address: item["BaseAddress"]
    }
  end
end
