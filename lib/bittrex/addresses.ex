defmodule Bittrex.Addresses do
  alias Bittrex.{HttpClient, HttpRequest}

  def get_addresses(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/addresses")
    |> HttpClient.send()
  end
end
