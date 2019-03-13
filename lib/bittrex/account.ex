defmodule Bittrex.Account do
  @moduledoc """
  Implements /account endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{HttpClient, HttpRequest}

  defstruct [:email, :id, :is_international]

  @doc """
  Retrieve account information.
  """
  def get_account(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/account")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> to_struct()
      |> Response.ok()
    end)
  end

  defp to_struct(data) do
    %__MODULE__{
      email: data["email"],
      id: data["id"],
      is_international: data["isInternational"]
    }
  end
end
