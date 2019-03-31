defmodule Bittrex.Addresses do
  @moduledoc """
  Implements /addresses endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, HttpRequest, Address}

  @doc """
  List deposit addresses.
  """
  @spec get_addresses(%Client{}) :: Response.t([%Address{}], Client.error())
  def get_addresses(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/addresses")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Address.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Request provisioning of a deposit address.
  """
  @spec create_address(%Client{}, %{currency_symbol: String.t()}) ::
          Response.t(%Address{}, Client.error())
  def create_address(client, address_attr) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:post)
    |> HttpRequest.put_body(address_attr)
    |> HttpRequest.put_path("/addresses")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Address.new()
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve the deposit address for a particular currency.
  """
  @spec get_address(%Client{}, String.t()) :: Response.t(%Address{}, Client.error())
  def get_address(client, currency_symbol) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/addresses/#{currency_symbol}")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Address.new()
      |> Response.ok()
    end)
  end
end
