defmodule Bittrex.Order do
  @moduledoc """
  A Bittrex Order.
  """

  @typedoc """
  - `id`: unique ID of this order.
  - `market_name`: unique name of the market this order is being placed on.
  - `direction`: order direction.
  - `type`: order type.
  - `quantity`: quantity.
  - `limit`: limit price, if present.
  - `ceiling`: ceiling, if present.
  - `time_in_force`: time in force.
  - `fill_quantity`: fill quantity.
  - `commission`: commission.
  - `proceeds`: proceeds.
  - `client_order_id`: client-provided identifier for advanced order tracking.
  - `status`: order status.
  - `created_at`: timestamp (UTC) of order creation.
  - `updated_at`: timestamp (UTC) of last order update.
  - `closed_at`: imestamp (UTC) when this order was closed.
  """
  @type t :: %__MODULE__{
    id: String.t(),
    market_name: String.t(),
    direction: String.t(),
    type: String.t(),
    quantity: number(),
    limit: number(),
    ceiling: number(),
    time_in_force: String.t(),
    fill_quantity: number(),
    commission: number(),
    proceeds: number(),
    client_order_id: String.t(),
    status: String.t(),
    created_at: NaiveDateTime.t(),
    updated_at: NaiveDateTime.t(),
    closed_at: NaiveDateTime.t(),
  }

  defstruct [
    :id,
    :market_name,
    :direction,
    :type,
    :quantity,
    :limit,
    :ceiling,
    :time_in_force,
    :fill_quantity,
    :commission,
    :proceeds,
    :client_order_id,
    :status,
    :created_at,
    :updated_at,
    :closed_at
  ]

  @doc false
  def new(data) do
    %__MODULE__{
      id: data["id"],
      market_name: data["marketName"],
      direction: data["direction"],
      type: data["type"],
      quantity: data["quantity"],
      limit: data["limit"],
      ceiling: data["ceiling"],
      time_in_force: data["timeInForce"],
      fill_quantity: data["fillQuantity"],
      commission: data["commission"],
      proceeds: data["proceeds"],
      client_order_id: data["clientOrderId"],
      status: data["status"],
      created_at: Bittrex.format_datetime(data["createdAt"]),
      updated_at: Bittrex.format_datetime(data["updatedAt"]),
      closed_at: Bittrex.format_datetime(data["closedAt"]),
    }
  end
end
