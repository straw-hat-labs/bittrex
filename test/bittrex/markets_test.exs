defmodule Bittrex.MarketsTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Markets, Market, MarketSummary, OrderBook, Trade, Candle, MarketSummary}

  test "GET /markets" do
    market_response = build_list(2, :market_response)
    markets = Enum.map(market_response, &Market.new/1)

    stub_request(%{body: Jason.encode!(market_response)})

    assert {:ok, ^markets} = Markets.get_markets(@client)
  end

  test "GET /markets/{marketName}" do
    market_response = build(:market_response)
    market = Market.new(market_response)

    stub_request(%{body: Jason.encode!(market_response)})

    assert {:ok, ^market} = Markets.get_market(@client, "BTC-DASH")
  end

  test "GET /markets/{marketName}/summary" do
    market_summary_response = build(:market_summary_response)
    market_summary = MarketSummary.new(market_summary_response)

    stub_request(%{body: Jason.encode!(market_summary_response)})

    assert {:ok, ^market_summary} = Markets.get_market_summary(@client, "BTC-DASH")
  end

  test "GET /markets/summaries" do
    market_summaries_response = build_list(2, :market_summary_response)
    market_summaries = Enum.map(market_summaries_response, &MarketSummary.new/1)

    stub_request(%{body: Jason.encode!(market_summaries_response)})

    assert {:ok, ^market_summaries} = Markets.get_market_summaries(@client)
  end

  test "GET /markets/{marketName}/orderbook" do
    order_book_response = build(:order_book_response)
    order_book = OrderBook.new(order_book_response)

    stub_request(%{body: Jason.encode!(order_book_response)})

    assert {:ok, ^order_book} = Markets.get_order_book(@client, "BTC-DASH")
  end

  test "GET /markets/{marketName}/trades" do
    trades_response = build_list(2, :trade_response)
    trades = Enum.map(trades_response, &Trade.new/1)

    stub_request(%{body: Jason.encode!(trades_response)})

    assert {:ok, ^trades} = Markets.get_market_trades(@client, "BTC-DASH")
  end

  test "GET /markets/{marketName}/candles" do
    candles_response = build_list(2, :candle_response)
    candles = Enum.map(candles_response, &Candle.new/1)

    stub_request(%{body: Jason.encode!(candles_response)})

    assert {:ok, ^candles} = Markets.get_market_candles(@client, "BTC-DASH")
  end
end
