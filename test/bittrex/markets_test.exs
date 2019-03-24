defmodule Bittrex.MarketsTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Markets, Market, MarketSummary, OrderBook, Trade, Candle, MarketSummary}

  test "GET /markets" do
    market_response = build_list(2, :market_response)
    markets = Enum.map(market_response, &Market.new/1)
    stub_request(market_response)

    assert {:ok, ^markets} = with_mock_client() |> Markets.get_markets()
  end

  test "GET /markets/{marketName}" do
    market_response = build(:market_response)
    market = Market.new(market_response)
    stub_request(market_response)

    assert {:ok, ^market} = with_mock_client() |> Markets.get_market("BTC-DASH")
  end

  test "GET /markets/{marketName}/summary" do
    market_summary_response = build(:market_summary_response)
    market_summary = MarketSummary.new(market_summary_response)
    stub_request(market_summary_response)

    assert {:ok, ^market_summary} = with_mock_client() |> Markets.get_market_summary("BTC-DASH")
  end

  test "GET /markets/summaries" do
    market_summaries_response = build_list(2, :market_summary_response)
    market_summaries = Enum.map(market_summaries_response, &MarketSummary.new/1) |> IO.inspect()
    stub_request(market_summaries_response)

    assert {:ok, ^market_summaries} = with_mock_client() |> Markets.get_market_summaries()
  end

  test "GET /markets/{marketName}/orderbook" do
    order_book_response = build(:order_book_response)
    order_book = OrderBook.new(order_book_response)
    stub_request(order_book_response)

    assert {:ok, ^order_book} = with_mock_client() |> Markets.get_order_book("BTC-DASH")
  end

  test "GET /markets/{marketName}/trades" do
    trades_response = build_list(2, :trade_response)
    trades = Enum.map(trades_response, &Trade.new/1)
    stub_request(trades_response)

    assert {:ok, ^trades} = with_mock_client() |> Markets.get_market_trades("BTC-DASH")
  end

  test "GET /markets/{marketName}/candles" do
    candles_response = build_list(2, :candle_response)
    candles = Enum.map(candles_response, &Candle.new/1)
    stub_request(candles_response)

    assert {:ok, ^candles} = with_mock_client() |> Markets.get_market_candles("BTC-DASH")
  end
end
