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
    response = Enum.map(result, &Currency.new/1)
    {:ok, response}
  end
  defp format_response({:error, message}), do: {:error, message}
end
