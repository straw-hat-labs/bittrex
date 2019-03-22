defmodule Bittrex.Orders do
  @moduledoc """
  Implements /orders endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{HttpClient, HttpRequest, Order, OrderCancelResult}

  @doc """
  List closed orders.
  """
  @spec get_closed_orders(%HttpClient{}, %{
          market_name: String.t(),
          starting_after: String.t(),
          ending_before: String.t(),
          limit: integer()
        }) :: Response.t([%Order{}], any())
  def get_closed_orders(client, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/orders/closed")
    |> HttpRequest.put_params(params)
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Order.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  List open orders.
  """
  @spec get_open_orders(%HttpClient{}, %{
          market_name: String.t()
        }) :: Response.t([%Order{}], any())
  def get_open_orders(client, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/orders/open")
    |> HttpRequest.put_params(params)
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Order.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve information on a specific order.
  """
  @spec get_order(%HttpClient{}, String.t()) :: Response.t(%Order{}, any())
  def get_order(client, order_id) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/orders/#{order_id}")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Order.new()
      |> Response.ok()
    end)
  end

  @doc """
  Cancel an order.
  """
  @spec cancel_order(%HttpClient{}, String.t()) :: Response.t(%OrderCancelResult{}, any())
  def cancel_order(client, order_id) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/orders/#{order_id}")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> OrderCancelResult.new()
      |> Response.ok()
    end)
  end

  @doc """
  Create a new order.
  """
  @spec create_order(%HttpClient{}, %{
          market_name: String.t(),
          direction: String.t(),
          type: String.t(),
          quantity: number(),
          limit: number(),
          ceiling: number(),
          time_in_force: String.t(),
          client_order_id: String.t()
        }) ::
          Response.t(%Order{}, any())
  def create_order(client, order_attrs) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:post)
    |> HttpRequest.put_body(order_attrs)
    |> HttpRequest.put_path("/orders")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Order.new()
      |> Response.ok()
    end)
  end
end
