defmodule Bittrex.Interactor.Account.GetDepositHistory do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Payment

  def call(currency) do
    HttpRequest.new(:get, "/account/getdeposithistory", [currency: currency])
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    result
    |> Enum.map(&Payment.new/1)
  end
  defp format_response({:error, message}), do: {:error, message}
end
