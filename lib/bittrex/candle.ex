defmodule Bittrex.Candle do
  @moduledoc """
  A Bittrex Candle.
  """

  @typedoc """
  - `tick`: time stamp of tick in UTC.
  - `open`: open.
  - `high`: high.
  - `low`: low.
  - `close`: close.
  - `volume`: volume.
  - `base_volume`: base volume.
  """
  @type t :: %__MODULE__{
    tick: NaiveDateTime.t(),
    open: number(),
    high: number(),
    low: number(),
    close: number(),
    volume: number(),
    base_volume: number(),
  }

  defstruct [:tick, :open, :high, :low, :close, :volume, :base_volume]

  @doc false
  def new(data) do
    %__MODULE__{
      tick: Bittrex.format_datetime(data["t"]),
      open: data["o"],
      high: data["h"],
      low: data["l"],
      close: data["c"],
      volume: data["v"],
      base_volume: data["bv"],
    }
  end
end
