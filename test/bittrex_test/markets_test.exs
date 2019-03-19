defmodule Bittrex.MarketsTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Markets, Market, MarketSummary, OrderBook}

  test "GET /markets" do
    use_cassette "get_markets" do
      assert {:ok, _markets} = with_mock_client() |> Markets.get_markets()
    end
  end

  test "GET /markets/{marketName}" do
    use_cassette "get_market" do
      assert {:ok, %Market{}} = with_mock_client() |> Markets.get_market("BTC-DASH")
    end
  end

  test "GET /markets/{marketName}/summary" do
    use_cassette "get_market_summary" do
      assert {:ok, %MarketSummary{}} = with_mock_client() |> Markets.get_market_summary("BTC-DASH")
    end
  end

  test "GET /markets/{marketName}/orderbook" do
    use_cassette "get_order_book" do
      assert {:ok, %OrderBook{}} = with_mock_client() |> Markets.get_order_book("BTC-DASH")
    end
  end

  test "GET /markets/{marketName}/trades" do
    use_cassette "get_market_trades" do
      assert {:ok, _trades} = with_mock_client() |> Markets.get_market_trades("BTC-DASH")
    end
  end

  test "GET /markets/{marketName}/candles" do
    use_cassette "get_market_candles" do
      assert {:ok, _candles} = with_mock_client() |> Markets.get_market_candles("BTC-DASH")
    end
  end

  test "GET /markets/summaries" do
    use_cassette "get_market_summaries" do
      assert {:ok, _market_summaries} = with_mock_client() |> Markets.get_market_summaries()
    end
  end
end
