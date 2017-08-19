defmodule Bittrex.Interactor.Account.GetDepositAddress do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Account.DepositAddress

  def call(currency) do
    :get
    |> HttpRequest.new("/account/getdepositaddress", [currency: currency])
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    response = DepositAddress.new(result)
    {:ok, response}
  end
  defp format_response({:error, message}), do: {:error, message}
end
