defmodule Bittrex.Currencies do
  @moduledoc """
  Implements /currencies endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{HttpClient, HttpRequest, Currency}

  @doc """
  List currencies with optional health info.
  """
  @spec get_currencies(%HttpClient{}) :: Response.t([%Currency{}], HttpClient.error())
  def get_currencies(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/currencies")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Currency.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve info on a specified currency.
  """
  @spec get_currency(%HttpClient{}, String.t()) :: Response.t(%Currency{}, HttpClient.error())
  def get_currency(client, currency_symbol) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/currencies/#{currency_symbol}")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Currency.new()
      |> Response.ok()
    end)
  end
end
