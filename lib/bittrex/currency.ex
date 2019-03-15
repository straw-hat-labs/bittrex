defmodule Bittrex.Currency do
  @moduledoc """
  A Bittrex Currency.
  """

  @typedoc """
  - `symbol`: unique symbol for this currency.
  - `name`: long name of this currency.
  - `base_address`: base address of this currency.
  - `coin_type`: coin type of this currency.
  - `status`: currency status (online, offline, etc.)
  - `is_international`: true if this market is restricted to international
  users.
  - `min_confirmations`: minimum number of confirmations.
  - `notice`: news or alerts regarding this currency.
  - `tx_fee`: transaction fee for this currency.
  """
  @type t :: %__MODULE__{
    symbol: String.t(),
    name: String.t(),
    base_address: String.t(),
    coin_type: String.t(),
    status: String.t(),
    is_international: boolean(),
    min_confirmations: integer(),
    notice: String.t(),
    tx_fee: number()
  }

  defstruct [
    :symbol,
    :name,
    :base_address,
    :coin_type,
    :status,
    :is_international,
    :min_confirmations,
    :notice,
    :tx_fee
  ]

  @doc false
  def new(data) do
    %__MODULE__{
      symbol: data["symbol"],
      name: data["name"],
      base_address: data["baseAddress"],
      coin_type: data["coinType"],
      status: data["status"],
      is_international: data["isInternational"],
      min_confirmations: data["minConfirmations"],
      notice: data["notice"],
      tx_fee: data["txFee"]
    }
  end
end
