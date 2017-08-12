defmodule Bittrex.Market do
  alias Bittrex.Interactor.Market.{GetMarkets}

  defstruct [:name, :display_name, :minimum_trade, :active, :created_at,
             :base_currency, :market_currency, :volume]

  def get_markets do
    GetMarkets.call()
  end
end
