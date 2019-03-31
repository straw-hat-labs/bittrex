defmodule Bittrex.TestSupport.Factory do
  @moduledoc false

  use ExMachina

  @some_date "2017-07-14T17:10:07.74Z"

  def account_response_factory do
    %{
      "id" => "123",
      "email" => "acmec@acmec.com",
      "isInternational" => true,
      "isFiat" => true
    }
  end

  def address_response_factory do
    %{
      "status" => "REQUESTED",
      "currencySymbol" => "BTC",
      "cryptoAddress" => "123"
    }
  end

  def balance_response_factory do
    %{
      "currencySymbol" => "BTC",
      "total" => 12.0,
      "available" => 5
    }
  end

  def currency_response_factory do
    %{
      "symbol" => "BTC",
      "name" => "Bitcoin",
      "baseAddress" => "123",
      "coinType" => "pepega",
      "status" => "ONLINE",
      "isInternational" => true,
      "minConfirmations" => 123_324_343,
      "notice" => "some alert or news",
      "txFee" => 10.5
    }
  end

  def deposit_response_factory do
    %{
      "id" => "123",
      "currencySymbol" => "BTC",
      "quantity" => 123.23,
      "address" => "123adresses",
      "txId" => "pepegatax",
      "confirmations" => 1235,
      "createdAt" => @some_date,
      "updatedAt" => @some_date,
      "status" => "COMPLETED"
    }
  end

  def service_status_response_factory do
    %{
      "status" => "123",
      "serverTime" => 12_351_243
    }
  end

  def order_response_factory do
    %{
      "id" => "123",
      "marketName" => "BTC",
      "direction" => "BUY",
      "type" => "MARKET",
      "quantity" => 1235.4,
      "limit" => 123.2,
      "ceiling" => 235.3,
      "timeInForce" => "GOOD_TIL_CANCELLED",
      "fillQuantity" => 345.5,
      "commission" => 754.4,
      "proceeds" => 754.4,
      "clientOrderId" => "1235",
      "status" => "OPEN",
      "createdAt" => @some_date,
      "updatedAt" => @some_date,
      "closedAt" => @some_date
    }
  end

  def order_cancel_result_response_factory do
    %{
      "id" => "123",
      "fillQuantity" => 564.4,
      "commission" => 564.4,
      "proceeds" => 564.4,
      "clientOrderId" => "454",
      "status" => "OPEN",
      "updatedAt" => @some_date,
      "closedAt" => @some_date
    }
  end

  def market_response_factory do
    %{
      "name" => "Ethereum",
      "baseCurrencySymbol" => "ETH",
      "baseCurrencyName" => "Ethereum",
      "quoteCurrencySymbol" => "ETH",
      "quoteCurrencyName" => "Ethereum",
      "minTradeSize" => 235.4,
      "status" => "ONLINE",
      "isInternational" => true,
      "createdAt" => @some_date,
      "notice" => "Pepega is cool",
      "logoUrl" => "http://nowhere.com/pepega.png"
    }
  end

  def market_summary_response_factory do
    %{
      "name" => "string",
      "high" => 23.5,
      "low" => 23.5,
      "volume" => 23.5,
      "last" => 23.5,
      "baseVolume" => 23.5,
      "bid" => 23.5,
      "ask" => 23.5,
      "openBuyOrders" => 23,
      "openSellOrders" => 23,
      "previousDay" => 23.5,
      "updatedAt" => @some_date
    }
  end

  def order_book_response_factory do
    %{
      "bid" => build_list(2, :order_book_entry),
      "ask" => build_list(2, :order_book_entry)
    }
  end

  def order_book_entry_factory do
    %{
      "quantity" => 1235.5,
      "rate" => 1235.5
    }
  end

  def trade_response_factory do
    %{
      "executedAt" => @some_date,
      "quantity" => 245.5,
      "rate" => 245.5
    }
  end

  def candle_response_factory do
    %{
      "t" => @some_date,
      "o" => 23.5,
      "h" => 23.5,
      "l" => 23.5,
      "c" => 23.5,
      "v" => 23.5,
      "bv" => 23.5
    }
  end

  def subaccount_response_factory do
    %{
      "id" => "123",
      "createdAt" => @some_date
    }
  end

  def withdrawal_response_factory do
    %{
      "id" => "1235",
      "currencySymbol" => "BTC",
      "quantity" => 453.2,
      "address" => "string",
      "txCost" => 453.2,
      "txId" => "123",
      "status" => "COMPLETED",
      "createdAt" => @some_date,
      "completedAt" => @some_date
    }
  end
end
