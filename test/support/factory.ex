defmodule Bittrex.TestSupport.Factory do
  @moduledoc false

  use ExMachina

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
    date_unix = "1553243950205"

    %{
      "id" => "123",
      "currencySymbol" => "BTC",
      "quantity" => 123.23,
      "address" => "123adresses",
      "txId" => "pepegatax",
      "confirmations" => 1235,
      "createdAt" => date_unix,
      "updatedAt" => date_unix,
      "status" => "COMPLETED"
    }
  end

  def service_status_factory do
    %{
      "status" => "123",
      "serverTime" => 12_351_243
    }
  end
end
