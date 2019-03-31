defmodule Bittrex.Currencies do
  @moduledoc """
  Implements /currencies endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, HttpRequest, Currency}

  @doc """
  List currencies with optional health info.
  """
  @spec get_currencies(%Client{}) :: Response.t([%Currency{}], Client.error())
  def get_currencies(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/currencies")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Currency.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve info on a specified currency.
  """
  @spec get_currency(%Client{}, String.t()) :: Response.t(%Currency{}, Client.error())
  def get_currency(client, currency_symbol) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/currencies/#{currency_symbol}")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Currency.new()
      |> Response.ok()
    end)
  end
end
