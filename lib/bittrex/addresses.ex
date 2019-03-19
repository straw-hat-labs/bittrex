defmodule Bittrex.Addresses do
  @moduledoc """
  Implements /addresses endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{HttpClient, HttpRequest, Address}

  @doc """
  List deposit addresses.
  """
  @spec get_addresses(%HttpClient{}) :: Response.t([%Address{}], any())
  def get_addresses(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/addresses")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Address.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Request provisioning of a deposit address.
  """
  @spec create_address(%HttpClient{}, %{ currency_symbol: String.t() }) :: Response.t(%Address{}, any())
  def create_address(client, address_attr) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:post)
    |> HttpRequest.put_body(address_attr)
    |> HttpRequest.put_path("/addresses")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Address.new()
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve the deposit address for a particular currency.
  """
  @spec get_address(%HttpClient{}, String.t()) :: Response.t(%Address{}, any())
  def get_address(client, currency_symbol) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/addresses/#{currency_symbol}")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Address.new()
      |> Response.ok()
    end)
  end
end
