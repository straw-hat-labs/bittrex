defmodule Bittrex.Currencies do
  @moduledoc """
  Implements /currencies endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, Client.Request, Currency}

  @doc """
  List currencies with optional health info.
  """
  @spec get_currencies(%Client{}) :: Response.t([%Currency{}], Client.error())
  def get_currencies(client) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/currencies")
    |> Client.send()
    |> StrawHat.Response.and_then(&Currency.transform_response/1)
  end

  @doc """
  Retrieve info on a specified currency.
  """
  @spec get_currency(%Client{}, String.t()) :: Response.t(%Currency{}, Client.error())
  def get_currency(client, currency_symbol) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/currencies/#{currency_symbol}")
    |> Client.send()
    |> StrawHat.Response.and_then(&Currency.transform_response/1)
  end
end
