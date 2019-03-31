defmodule Bittrex.Trade do
  @moduledoc """
  A Bittrex Trade.
  """

  alias StrawHat.Response

  @typedoc """
  - `executed_at`: timestamp in UTC when order was filled.
  - `quantity`: quantity.
  - `rate`: rate.
  """
  @type t :: %__MODULE__{
          executed_at: NaiveDateTime.t(),
          quantity: String.t(),
          rate: integer()
        }

  defstruct [:executed_at, :quantity, :rate]

  @doc false
  def new(data) do
    %__MODULE__{
      executed_at: Bittrex.format_datetime(data["executedAt"]),
      quantity: data["quantity"],
      rate: data["rate"]
    }
  end

  @doc false
  def transform_response(data) when is_list(data) do
    data
    |> Enum.map(&new/1)
    |> Response.ok()
  end
end
