defmodule Bittrex.MarketSummary do
  @moduledoc """
  A Bittrex MarketSummary.
  """

  @typedoc """
  - `name`: unique name for this market.
  - `high`: high.
  - `low`: low.
  - `volume`: volume.
  - `last`: last.
  - `base_volume`: base volume.
  - `bid`: bid.
  - `ask`: ask.
  - `open_buy_orders`: count of open buy orders.
  - `open_sell_orders`: count of open sell orders.
  - `previous_day`: previous day.
  - `updated_at`: timestamp in UTC when market summary was last updated.
  """
  @type t :: %__MODULE__{
          name: String.t(),
          high: number(),
          low: number(),
          volume: number(),
          last: number(),
          base_volume: number(),
          bid: number(),
          ask: number(),
          open_buy_orders: integer(),
          open_sell_orders: integer(),
          previous_day: number(),
          updated_at: NaiveDateTime.t()
        }

  defstruct [
    :name,
    :high,
    :low,
    :volume,
    :last,
    :base_volume,
    :bid,
    :ask,
    :open_buy_orders,
    :open_sell_orders,
    :previous_day,
    :updated_at
  ]

  @doc false
  def new(data) do
    %__MODULE__{
      name: data["name"],
      high: data["high"],
      low: data["low"],
      volume: data["volume"],
      last: data["last"],
      base_volume: data["baseVolume"],
      bid: data["bid"],
      ask: data["ask"],
      open_buy_orders: data["openBuyOrders"],
      open_sell_orders: data["openSellOrders"],
      previous_day: data["previousDay"],
      updated_at: Bittrex.format_datetime(data["updatedAt"])
    }
  end
end
