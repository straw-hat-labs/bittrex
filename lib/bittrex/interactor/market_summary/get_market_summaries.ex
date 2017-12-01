defmodule Bittrex.Interactor.MarketSummary.GetMarketSummaries do
  @moduledoc false

  use Bittrex.Interactor
  alias Bittrex.MarketSummary

  def call do
    :get
    |> HttpRequest.new("/public/getmarketsummaries")
    |> Client.send()
    |> format_response()
  end

  defp format_response({:ok, result}) do
    response = Enum.map(result, &MarketSummary.new/1)
    {:ok, response}
  end

  defp format_response({:error, message}), do: {:error, message}
end
