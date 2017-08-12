defmodule Bittrex.Market do
  alias Bittrex.{Market, Currency}
  alias Bittrex.Interactor.Market.{GetMarkets}

  defstruct [:name, :display_name, :minimum_trade, :active, :created_at,
             :base_currency, :market_currency, :volume]

  def get_markets do
    GetMarkets.call()
  end

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
