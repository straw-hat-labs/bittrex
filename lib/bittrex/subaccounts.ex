defmodule Bittrex.Subaccounts do
  @moduledoc """
  Implements /subaccounts endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Subaccount, Client, Client.Request}

  @doc """
  List subaccounts. (NOTE: This API is limited to partners and not available
  for traders.)
  """
  @spec get_subaccounts(%Client{}, %{
          starting_after: String.t(),
          ending_before: String.t(),
          limit: integer()
        }) :: Response.t([%Subaccount{}], Client.error())
  def get_subaccounts(client, params \\ %{}) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/subaccounts")
    |> Request.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Subaccount.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Create a new subaccount. (NOTE: This API is limited to partners and not
  available for traders.)
  """
  @spec create_subaccount(%Client{}, %{}) :: Response.t(%Subaccount{}, Client.error())
  def create_subaccount(client, params \\ %{}) do
    client
    |> Request.new()
    |> Request.put_method(:post)
    |> Request.put_path("/subaccounts")
    |> Request.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Subaccount.new()
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve details for a specified subaccount. (NOTE: This API is limited to
  partners and not available for traders.)
  """
  @spec get_subaccount(%Client{}, String.t()) :: Response.t(%Subaccount{}, Client.error())
  def get_subaccount(client, subaccount_id) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/subaccounts/#{subaccount_id}")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Subaccount.new()
      |> Response.ok()
    end)
  end
end
