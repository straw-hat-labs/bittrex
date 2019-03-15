defmodule Bittrex.Balance do
  @moduledoc """
  A Bittrex Balance
  """

  defstruct [:total, :currency_symbol, :available]

  @doc false
  def to_struct(data) do
    %__MODULE__{
      total: data["total"],
      currency_symbol: data["currencySymbol"],
      available: data["available"]
    }
  end
end
