defmodule Bittrex.Withdrawal do
  @moduledoc """
  A Bittrex Withdrawal.
  """

  @typedoc """
  - `id`: unique ID for this withdrawal.
  - `currency_symbol`: unique symbol of currency to withdraw.
  - `quantity`: quantity to withdraw.
  - `address`: crypto address for this withdrawal.
  - `tx_cost`: TxCost of this withdrawal.
  - `tx_id`: TxID associated with this withdrawal.
  - `status`: current status of this withdrawal.
  - `created_at`: time stamp when this withdrawal was initiated.
  - `completed_at`: time stamp when this withdrawal was completed.
  """
  @type t :: %__MODULE__{
          id: String.t(),
          currency_symbol: String.t(),
          quantity: number(),
          address: String.t(),
          tx_cost: number(),
          tx_id: String.t(),
          status: String.t(),
          created_at: NaiveDateTime.t(),
          completed_at: NaiveDateTime.t()
        }

  defstruct [
    :id,
    :currency_symbol,
    :quantity,
    :address,
    :tx_cost,
    :tx_id,
    :status,
    :created_at,
    :completed_at
  ]

  @doc false
  def new(data) do
    %__MODULE__{
      id: data["id"],
      currency_symbol: data["currencySymbol"],
      quantity: data["quantity"],
      address: data["address"],
      tx_cost: data["txCost"],
      tx_id: data["txId"],
      status: data["status"],
      created_at: Bittrex.format_datetime(data["createdAt"]),
      completed_at: Bittrex.format_datetime(data["completedAt"])
    }
  end
end
