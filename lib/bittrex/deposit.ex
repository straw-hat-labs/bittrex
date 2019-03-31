defmodule Bittrex.Deposit do
  @moduledoc """
  A Bittrex Deposit.
  """

  alias StrawHat.Response

  @typedoc """
  - `id`: unique ID for this deposit.
  - `currency_symbol`: unique symbol of the currency being deposited to.
  - `quantity`: quantity to deposit.
  - `address`: crypto address for this deposit.
  - `tx_id`: TxID for the deposit.
  - `confirmations`: current count of confirmations.
  - `created_at`: time stamp when this deposit was initiated.
  - `updated_at`: time stamp when this deposit was last updated.
  - `status`: current status of this deposit.
  """
  @type t :: %__MODULE__{
          id: String.t(),
          currency_symbol: String.t(),
          quantity: number(),
          address: String.t(),
          tx_id: String.t(),
          confirmations: integer(),
          created_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t(),
          status: String.t()
        }

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
