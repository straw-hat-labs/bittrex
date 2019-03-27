defmodule Bittrex.Withdrawals do
  @moduledoc """
  Implements /withdrawals endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Withdrawal, HttpClient, HttpRequest}

  @doc """
  List withdrawals.
  """
  @spec get_withdrawals(%HttpClient{}, %{
          status: String.t(),
          currency_symbol: String.t(),
          starting_after: String.t(),
          ending_before: String.t(),
          limit: integer()
        }) :: Response.t([%Withdrawal{}], HttpClient.error())
  def get_withdrawals(client, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/withdrawals")
    |> HttpRequest.put_params(params)
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Withdrawal.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve information on a specified withdrawal.
  """
  @spec get_withdrawal(%HttpClient{}, String.t()) :: Response.t(%Withdrawal{}, HttpClient.error())
  def get_withdrawal(client, withdrawal_id) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/withdrawals/#{withdrawal_id}")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Withdrawal.new()
      |> Response.ok()
    end)
  end

  @doc """
  Cancel a withdrawal.
  """
  @spec delete_withdrawal(%HttpClient{}, String.t()) :: Response.t(String.t(), HttpClient.error())
  def delete_withdrawal(client, withdrawal_id) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:delete)
    |> HttpRequest.put_path("/withdrawals/#{withdrawal_id}")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(&Response.ok/1)
  end

  @doc """
  Create a new withdrawal.
  """
  @spec create_withdrawal(%HttpClient{}, %{
          currency_symbol: String.t(),
          quantity: number(),
          address: String.t(),
          message: String.t()
        }) :: Response.t(%Withdrawal{}, HttpClient.error())
  def create_withdrawal(client, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:post)
    |> HttpRequest.put_path("/withdrawals")
    |> HttpRequest.put_params(params)
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Withdrawal.new()
      |> Response.ok()
    end)
  end
end
