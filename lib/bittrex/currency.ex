defmodule Bittrex.Currency do
  @moduledoc """
  A Bittrex Currency
  """

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
