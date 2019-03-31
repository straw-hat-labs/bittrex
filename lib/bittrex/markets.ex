defmodule Bittrex.Markets do
  @moduledoc """
  Implements /markets endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, HttpRequest, Market, MarketSummary, OrderBook, Trade, Candle}

  @doc """
  List markets.
  """
  @spec get_markets(%Client{}, %{}) :: Response.t([%Market{}], Client.error())
  def get_markets(client, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets")
    |> HttpRequest.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Market.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve information for a specific market.
  """
  @spec get_market(%Client{}, String.t()) :: Response.t(%Market{}, Client.error())
  def get_market(client, market_name) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets/#{market_name}")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Market.new()
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve summary for a specific market.
  """
  @spec get_market_summary(%Client{}, String.t()) ::
          Response.t(%MarketSummary{}, Client.error())
  def get_market_summary(client, market_name) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets/#{market_name}/summary")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> MarketSummary.new()
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve the order book for a specific market.
  """
  @spec get_order_book(%Client{}, String.t(), %{
          depth: integer()
        }) :: Response.t(%OrderBook{}, Client.error())
  def get_order_book(client, market_name, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets/#{market_name}/orderbook")
    |> HttpRequest.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> OrderBook.new()
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve the recent trades for a specific market.
  """
  @spec get_market_trades(%Client{}, String.t()) :: Response.t(%Trade{}, Client.error())
  def get_market_trades(client, market_name) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets/#{market_name}/trades")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Trade.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  Retrieve candles for a specific market.
  """
  @spec get_market_candles(%Client{}, String.t(), %{
          candle_interval: String.t()
        }) :: Response.t(%Candle{}, Client.error())
  def get_market_candles(client, market_name, params \\ %{}) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets/#{market_name}/trades")
    |> HttpRequest.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&Candle.new/1)
      |> Response.ok()
    end)
  end

  @doc """
  List market summaries.
  """
  @spec get_market_summaries(%Client{}) :: Response.t(%MarketSummary{}, Client.error())
  def get_market_summaries(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/markets")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> Enum.map(&MarketSummary.new/1)
      |> Response.ok()
    end)
  end
end
