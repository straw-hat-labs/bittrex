defmodule Bittrex.Markets do
  @moduledoc """
  Implements /markets endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{HttpClient, HttpRequest, Market, MarketSummary, OrderBook, Trade, Candle}

  @doc """
  List markets.
  """
  @spec get_markets(%HttpClient{}, %{}) :: Response.t([%Market{}], any())
  def get_markets(client, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets")
    |> HttpRequest.put_params(params)
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Market.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve information for a specific market.
  """
  @spec get_market(%HttpClient{}, String.t()) :: Response.t(%Market{}, any())
  def get_market(client, market_name) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets/#{market_name}")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Market.new()
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve summary for a specific market.
  """
  @spec get_market_summary(%HttpClient{}, String.t()) :: Response.t(%MarketSummary{}, any())
  def get_market_summary(client, market_name) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets/#{market_name}/summary")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> MarketSummary.new()
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve the order book for a specific market.
  """
  @spec get_order_book(%HttpClient{}, String.t(), %{
    depth: integer(),
  }) :: Response.t(%OrderBook{}, any())
  def get_order_book(client, market_name, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets/#{market_name}/orderbook")
    |> HttpRequest.put_params(params)
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> OrderBook.new()
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve the recent trades for a specific market.
  """
  @spec get_market_trades(%HttpClient{}, String.t()) :: Response.t(%Trade{}, any())
  def get_market_trades(client, market_name) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets/#{market_name}/trades")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Trade.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve candles for a specific market.
  """
  @spec get_market_candles(%HttpClient{}, String.t(), %{
    candle_interval: String.t()
  }) :: Response.t(%Candle{}, any())
  def get_market_candles(client, market_name, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets/#{market_name}/trades")
    |> HttpRequest.put_params(params)
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Candle.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  List market summaries.
  """
  @spec get_market_summaries(%HttpClient{}) :: Response.t(%MarketSummary{}, any())
  def get_market_summaries(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&MarketSummary.new/1)
      |> Response.ok()
    end)
  end
end
