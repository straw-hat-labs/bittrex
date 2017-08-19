defmodule Bittrex.Interactor.Account.GetDepositAddress do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Account.DepositAddress

  def call(currency) do
    HttpRequest.new(:get, "/account/getdepositaddress", [currency: currency])
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    DepositAddress.new(result)
  end
  defp format_response({:error, message}), do: {:error, message}
end
