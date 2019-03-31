defmodule Bittrex.Balances do
  @moduledoc """
  Implements /balances endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, Client.Request, Balance}

  @doc """
  List account balances across available currencies.
  """
  @spec get_balances(%Client{}) :: Response.t([%Balance{}], Client.error())
  def get_balances(client) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/balances")
    |> Client.send()
    |> StrawHat.Response.and_then(&Balance.transform_response/1)
  end

  @doc """
  Retrieve account balance for a specific currency.
  """
  @spec get_balance(%Client{}, String.t()) :: Response.t(%Balance{}, Client.error())
  def get_balance(client, currency_symbol) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/balances/#{currency_symbol}")
    |> Client.send()
    |> StrawHat.Response.and_then(&Balance.transform_response/1)
  end
end
