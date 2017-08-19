defmodule Bittrex.Interactor.Account.GetBalance do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Account.AccountBalance

  def call(currency) do
    HttpRequest.new(:get, "/account/getbalance", [currency: currency])
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    response = AccountBalance.new(result)
    {:ok, response}
  end
  defp format_response({:error, message}), do: {:error, message}
end
