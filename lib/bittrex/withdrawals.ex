defmodule Bittrex.Withdrawals do
  @moduledoc """
  Implements /withdrawals endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Withdrawal, Client, HttpRequest}

  @doc """
  List withdrawals.
  """
  @spec get_withdrawals(%Client{}, %{
          status: String.t(),
          currency_symbol: String.t(),
          starting_after: String.t(),
          ending_before: String.t(),
          limit: integer()
        }) :: Response.t([%Withdrawal{}], Client.error())
  def get_withdrawals(client, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/withdrawals")
    |> HttpRequest.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Withdrawal.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve information on a specified withdrawal.
  """
  @spec get_withdrawal(%Client{}, String.t()) :: Response.t(%Withdrawal{}, Client.error())
  def get_withdrawal(client, withdrawal_id) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/withdrawals/#{withdrawal_id}")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Withdrawal.new()
      |> Response.ok()
    end)
  end

  @doc """
  Cancel a withdrawal.
  """
  @spec delete_withdrawal(%Client{}, String.t()) :: Response.t(String.t(), Client.error())
  def delete_withdrawal(client, withdrawal_id) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:delete)
    |> HttpRequest.put_path("/withdrawals/#{withdrawal_id}")
    |> Client.send()
    |> StrawHat.Response.and_then(&Response.ok/1)
  end

  @doc """
  Create a new withdrawal.
  """
  @spec create_withdrawal(%Client{}, %{
          currency_symbol: String.t(),
          quantity: number(),
          address: String.t(),
          message: String.t()
        }) :: Response.t(%Withdrawal{}, Client.error())
  def create_withdrawal(client, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:post)
    |> HttpRequest.put_path("/withdrawals")
    |> HttpRequest.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Withdrawal.new()
      |> Response.ok()
    end)
  end
end
