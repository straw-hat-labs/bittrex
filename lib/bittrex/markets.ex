defmodule Bittrex.Markets do
  @moduledoc """
  Implements /markets endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, Client.Request, Market, MarketSummary, OrderBook, Trade, Candle}

  @doc """
  List markets.
  """
  @spec get_markets(%Client{}, %{}) :: Response.t([%Market{}], Client.error())
  def get_markets(client, params \\ %{}) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/markets")
    |> Request.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(&Market.transform_response/1)
  end

  @doc """
  Retrieve information for a specific market.
  """
  @spec get_market(%Client{}, String.t()) :: Response.t(%Market{}, Client.error())
  def get_market(client, market_name) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/markets/#{market_name}")
    |> Client.send()
    |> StrawHat.Response.and_then(&Market.transform_response/1)
  end

  @doc """
  Retrieve summary for a specific market.
  """
  @spec get_market_summary(%Client{}, String.t()) ::
          Response.t(%MarketSummary{}, Client.error())
  def get_market_summary(client, market_name) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/markets/#{market_name}/summary")
    |> Client.send()
    |> StrawHat.Response.and_then(&MarketSummary.transform_response/1)
  end

  @doc """
  Retrieve the order book for a specific market.
  """
  @spec get_order_book(%Client{}, String.t(), %{
          depth: integer()
        }) :: Response.t(%OrderBook{}, Client.error())
  def get_order_book(client, market_name, params \\ %{}) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/markets/#{market_name}/orderbook")
    |> Request.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(&OrderBook.transform_response/1)
  end

  @doc """
  Retrieve the recent trades for a specific market.
  """
  @spec get_market_trades(%Client{}, String.t()) :: Response.t(%Trade{}, Client.error())
  def get_market_trades(client, market_name) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/markets/#{market_name}/trades")
    |> Client.send()
    |> StrawHat.Response.and_then(&Trade.transform_response/1)
  end

  @doc """
  Retrieve candles for a specific market.
  """
  @spec get_market_candles(%Client{}, String.t(), %{
          candle_interval: String.t()
        }) :: Response.t(%Candle{}, Client.error())
  def get_market_candles(client, market_name, params \\ %{}) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/markets/#{market_name}/trades")
    |> Request.put_params(params)
    |> Client.send()
    |> StrawHat.Response.and_then(&Candle.transform_response/1)
  end

  @doc """
  List market summaries.
  """
  @spec get_market_summaries(%Client{}) :: Response.t(%MarketSummary{}, Client.error())
  def get_market_summaries(client) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/markets")
    |> Client.send()
    |> StrawHat.Response.and_then(&MarketSummary.transform_response/1)
  end
end
