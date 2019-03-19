defmodule Bittrex.OrderBookEntry do
  @moduledoc """
  A Bittrex Order Book Entry.
  """

  @typedoc """
  - `quantity`: quantity.
  - `rate`: rate.
  """
  @type t :: %__MODULE__{
          quantity: number(),
          rate: number()
        }

  defstruct [:quantity, :rate]

  @doc false
  def new(data) do
    %__MODULE__{
      quantity: data["quantity"],
      rate: data["rate"]
    }
  end
end
