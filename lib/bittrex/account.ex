defmodule Bittrex.Account do
  @moduledoc """
  Implements /account endpoints.
  """

  alias Bittrex.{HttpClient, HttpRequest}

  @doc """
  Retrieve account information.
  """
  def get_account(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/account")
    |> HttpClient.send()
  end
end
