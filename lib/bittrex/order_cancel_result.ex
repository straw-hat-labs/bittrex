defmodule Bittrex.OrderCancelResult do
  @moduledoc """
  A Bittrex Order Cancel Result.
  """

  @typedoc """
  - `id`: unique ID of this order.
  - `fill_quantity`: fill quantity.
  - `commission`: commission.
  - `proceeds`: proceeds.
  - `client_order_id`: client-provided identifier for advanced order tracking.
  - `status`: order status.
  - `updated_at`: timestamp (UTC) of last order update.
  - `closed_at`: timestamp (UTC) when this order was closed.
  """
  @type t :: %__MODULE__{
          id: String.t(),
          fill_quantity: number(),
          commission: number(),
          proceeds: number(),
          client_order_id: String.t(),
          status: String.t(),
          updated_at: NaiveDateTime.t(),
          closed_at: NaiveDateTime.t()
        }

  defstruct [
    :id,
    :fill_quantity,
    :commission,
    :proceeds,
    :client_order_id,
    :status,
    :updated_at,
    :closed_at
  ]

  @doc false
  def new(data) do
    %__MODULE__{
      id: data["id"],
      fill_quantity: data["fillQuantity"],
      commission: data["commission"],
      proceeds: data["proceeds"],
      client_order_id: data["clientOrderId"],
      status: data["status"],
      updated_at: Bittrex.format_datetime(data["updatedAt"]),
      closed_at: Bittrex.format_datetime(data["closedAt"])
    }
  end
end
