defmodule Bittrex.Address do
  @moduledoc """
  A Bittrex Address
  """

  defstruct [:status, :currency_symbol, :crypto_address]

  @doc false
  def to_struct(data) do
    %__MODULE__{
      status: data["status"],
      currency_symbol: data["currencySymbol"],
      crypto_address: data["cryptoAddress"]
    }
  end
end
