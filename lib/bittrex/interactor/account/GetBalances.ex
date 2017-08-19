defmodule Bittrex.Interactor.Account.GetBalances do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Account.AccountBalance

  def call do
    HttpRequest.new(:get, "/account/getbalances")
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    result
    |> Enum.map(&AccountBalance.new/1)
  end
  defp format_response({:error, message}), do: {:error, message}
end
