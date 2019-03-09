defmodule Bittrex.Addresses do
  @moduledoc """
  Implements /addresses endpoints.
  """

  alias Bittrex.{HttpClient, HttpRequest}

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
end
