defmodule Bittrex.Interactor.Account.GetBalances do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Account.AccountBalance

  def call do
    :get
    |> HttpRequest.new("/account/getbalances")
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    response = Enum.map(result, &AccountBalance.new/1)
    {:ok, response}
  end

  defp format_response({:error, message}), do: {:error, message}
end
