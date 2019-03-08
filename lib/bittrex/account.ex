defmodule Bittrex.Account do
  alias Bittrex.{HttpClient, HttpRequest}

  def get_account(client) do
    client
    |> HttpRequest.new(:get, "/account")
    |> HttpClient.send()
  end
end
