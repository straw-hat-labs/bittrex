defmodule Bittrex.Balance do
  @moduledoc """
  A Bittrex Balance.
  """

  alias StrawHat.Response

  @typedoc """
  - `total`: total amount.
  - `currency_symbol`: unique ID for the currency this balance is associated
  with.
  - `available`: available amount.
  """
  @type t :: %__MODULE__{
          total: number(),
          currency_symbol: String.t(),
          available: number()
        }

  defstruct [:total, :currency_symbol, :available]

  @doc false
  def new(data) do
    %__MODULE__{
      total: data["total"],
      currency_symbol: data["currencySymbol"],
      available: data["available"]
    }
  end

  @doc false
  def transform_response(data) when is_list(data) do
    data
    |> Enum.map(&new/1)
    |> Response.ok()
  end

  @doc false
  def transform_response(data) do
    data
    |> new()
    |> Response.ok()
  end
end
