defmodule Bittrex.Orders do
  @moduledoc """
  Implements /orders endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, Client.Request, Order, OrderCancelResult}

  @doc """
  List closed orders.
  """
  @spec get_closed_orders(%Client{}, %{
          market_name: String.t(),
          starting_after: String.t(),
          ending_before: String.t(),
          limit: integer()
        }) :: Response.t([%Order{}], Client.error())
  def get_closed_orders(client, params \\ %{}) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/orders/closed")
    |> Request.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Order.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  List open orders.
  """
  @spec get_open_orders(%Client{}, %{
          market_name: String.t()
        }) :: Response.t([%Order{}], Client.error())
  def get_open_orders(client, params \\ %{}) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/orders/open")
    |> Request.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Order.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve information on a specific order.
  """
  @spec get_order(%Client{}, String.t()) :: Response.t(%Order{}, Client.error())
  def get_order(client, order_id) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/orders/#{order_id}")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Order.new()
      |> Response.ok()
    end)
  end

  @doc """
  Cancel an order.
  """
  @spec cancel_order(%Client{}, String.t()) ::
          Response.t(%OrderCancelResult{}, Client.error())
  def cancel_order(client, order_id) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/orders/#{order_id}")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> OrderCancelResult.new()
      |> Response.ok()
    end)
  end

  @doc """
  Create a new order.
  """
  @spec create_order(%Client{}, %{
          market_name: String.t(),
          direction: String.t(),
          type: String.t(),
          quantity: number(),
          limit: number(),
          ceiling: number(),
          time_in_force: String.t(),
          client_order_id: String.t()
        }) ::
          Response.t(%Order{}, Client.error())
  def create_order(client, order_attrs) do
    client
    |> Request.new()
    |> Request.put_method(:post)
    |> Request.put_body(order_attrs)
    |> Request.put_path("/orders")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Order.new()
      |> Response.ok()
    end)
  end
end
