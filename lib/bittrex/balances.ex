defmodule Bittrex.Balances do
  @moduledoc """
  Implements /balances endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, HttpRequest, Balance}

  @doc """
  List account balances across available currencies.
  """
  @spec get_balances(%Client{}) :: Response.t([%Balance{}], Client.error())
  def get_balances(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/balances")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Balance.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve account balance for a specific currency.
  """
  @spec get_balance(%Client{}, String.t()) :: Response.t(%Balance{}, Client.error())
  def get_balance(client, currency_symbol) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/balances/#{currency_symbol}")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Balance.new()
      |> Response.ok()
    end)
  end
end
