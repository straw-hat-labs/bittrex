defmodule Bittrex.Interactor.Currency.GetCurrencies do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.Currency

  def call do
    HttpRequest.new(:get, "/public/getcurrencies")
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    result
    |> Enum.map(&Currency.new/1)
  end
  defp format_response({:error, message}), do: {:error, message}
end
