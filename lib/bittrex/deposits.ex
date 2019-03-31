defmodule Bittrex.Deposits do
  @moduledoc """
  Implements /deposits endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, HttpRequest, Deposit}

  @doc """
  List historical deposits.
  """
  @spec get_deposits(%Client{}, %{
          status: String.t(),
          currency_symbol: String.t(),
          starting_after: String.t(),
          ending_before: String.t(),
          limit: integer()
        }) :: Response.t([%Deposit{}], Client.error())
  def get_deposits(client, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/deposits")
    |> HttpRequest.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Deposit.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve information for a specific deposit. (NOT YET IMPLEMENTED)
  """
  @spec get_deposit(%Client{}, String.t()) :: Response.t(%Deposit{}, Client.error())
  def get_deposit(client, deposit_id) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/deposits/#{deposit_id}")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Deposit.new()
      |> Response.ok()
    end)
  end
end
