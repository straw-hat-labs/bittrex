defmodule Bittrex.Deposits do
  @moduledoc """
  Implements /deposits endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{HttpClient, HttpRequest, Deposit}

  @doc """
  List historical deposits.
  """
  def get_deposits(client, params \\ %{}) do
    params = Bittrex.camelcase_keys(params)

    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/deposits")
    |> HttpRequest.put_params(params)
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Deposit.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  List pending deposits.
  """
  def get_pending_deposits(client, params \\ %{}) do
    params = Bittrex.camelcase_keys(params)

    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/deposits/pending")
    |> HttpRequest.put_params(params)
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Deposit.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve information for a specific deposit. (NOT YET IMPLEMENTED).
  """
  def get_deposit(client, deposit_id) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/deposits/#{deposit_id}")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Deposit.new()
      |> Response.ok()
    end)
  end
end
