defmodule Bittrex.Addresses do
  @moduledoc """
  Implements /addresses endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{HttpClient, HttpRequest, Address}

  @doc """
  List deposit addresses.
  """
  def get_addresses(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/addresses")
    |> HttpClient.send()
  end

  @doc """
  Request provisioning of a deposit address.
  """
  def create_address(client, address_attr) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:post)
    |> HttpRequest.put_body(address_attr)
    |> HttpRequest.put_path("/addresses")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Address.to_struct()
      |> Response.ok()
    end)
  end
end
