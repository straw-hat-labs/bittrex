defmodule Bittrex.Market do
  alias Bittrex.{Market, Currency}
  alias Bittrex.Interactor.Market.{
    GetMarkets, GetMarketHistory, BuyLimit, SellLimit, GetOpenOrders}

  defstruct [:name, :display_name, :minimum_trade, :active, :created_at,
             :base_currency, :market_currency, :volume]

  def get_markets do
    GetMarkets.call()
  end

  def get_market_history(market_name) do
    GetMarketHistory.call(market_name)
  end

  def buy_limit(market_name, quantity, rate) do
    BuyLimit.call(market_name, quantity, rate)
  end

  def sell_limit(market_name, quantity, rate) do
    SellLimit.call(market_name, quantity, rate)
  end

  def get_open_orders(market_name) do
    GetOpenOrders.call(market_name)
  end

  def new(name) when is_binary(name), do: %Market{name: name}
  def new(item) do
    %Market{
      name: item["MarketName"],
      minimum_trade: item["MinTradeSize"],
      active: item["IsActive"],
      created_at: Bittrex.format_datetime(item["Created"]),
      base_currency: %Currency{
        code: item["BaseCurrency"],
        name: item["BaseCurrencyLong"]
      },
      market_currency: %Currency{
        code: item["MarketCurrency"],
        name: item["MarketCurrencyLong"]
      }
    }
  end
end
