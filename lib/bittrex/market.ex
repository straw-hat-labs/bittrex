defmodule Bittrex.Market do
  @moduledoc """
  A Bittrex Market.
  """

  @typedoc """
  - `name`: unique name for this market.
  - `base_currency_symbol`: unique symbol for base currency.
  - `base_currency_name`: long name for base currency.
  - `quote_currency_symbol`: unique symbol for quote currency.
  - `quote_currency_name`: long name for quote currency.
  - `min_trade_size`: minimum trade size.
  - `status`: true if this market is currently active.
  - `is_international`: true if this market is restricted to international
  users.
  - `created_at`: timestamp in UTC when this market was created.
  - `notice`: notice or alert info.
  - `logo_url`: logo URL.
  """
  @type t :: %__MODULE__{
          name: String.t(),
          base_currency_symbol: String.t(),
          base_currency_name: String.t(),
          quote_currency_symbol: String.t(),
          quote_currency_name: String.t(),
          min_trade_size: number(),
          status: String.t(),
          is_international: boolean(),
          created_at: NaiveDateTime.t(),
          notice: String.t(),
          logo_url: String.t()
        }

  defstruct [
    :name,
    :base_currency_symbol,
    :base_currency_name,
    :quote_currency_symbol,
    :quote_currency_name,
    :min_trade_size,
    :status,
    :is_international,
    :created_at,
    :notice,
    :logo_url
  ]

  @doc false
  def new(data) do
    %__MODULE__{
      name: data["name"],
      base_currency_symbol: data["baseCurrencySymbol"],
      base_currency_name: data["baseCurrencyName"],
      quote_currency_symbol: data["quoteCurrencySymbol"],
      quote_currency_name: data["quoteCurrencyName"],
      min_trade_size: data["minTradeSize"],
      status: data["status"],
      is_international: data["isInternational"],
      created_at: Bittrex.format_datetime(data["createdAt"]),
      notice: data["notice"],
      logo_url: data["logoUrl"]
    }
  end
end
