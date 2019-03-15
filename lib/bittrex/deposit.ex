defmodule Bittrex.Deposit do
  @moduledoc """
  A Bittrex Deposit
  """

  defstruct [
    :id,
    :currency_symbol,
    :quantity,
    :address,
    :tx_id,
    :confirmations,
    :created_at,
    :updated_at,
    :status
  ]

  @doc false
  def new(data) do
    %__MODULE__{
      id: data["id"],
      currency_symbol: data["currencySymbol"],
      quantity: data["quantity"],
      address: data["address"],
      tx_id: data["txId"],
      confirmations: data["confirmations"],
      created_at: Bittrex.format_datetime(data["createdAt"]),
      updated_at: Bittrex.format_datetime(data["updatedAt"]),
      status: data["status"]
    }
  end
end
