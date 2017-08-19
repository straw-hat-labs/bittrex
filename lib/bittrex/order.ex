defmodule Bittrex.Order do
  alias Bittrex.Interactor.Order.{CancelOrder}
  alias Bittrex.Order.{OrderStatus, OrderCondition}
  alias Bittrex.{Order, Market}

  defstruct [:id, :quantity, :quantity_remaining, :price, :type,
             :total, :fill_type, :limit, :commision, :price_per_unit,
             :status, :cancelation_initiated, :immediate_or_cancel,
             :condition, :market, :traded_at]

  def cancel_order(order_id) do
    CancelOrder.call(order_id)
  end

  def new(item) do
    item["OrderType"]
    |> String.downcase()
    |> new(item)
  end
  def new(type, item) do
    %Order{
      id: get_order_id(item),
      price: get_price(item),
      type: type,
      traded_at: Bittrex.format_datetime(item["TimeStamp"]),
      quantity: item["Quantity"],
      quantity_remaining: item["QuantityRemaining"],
      total: item["Total"],
      fill_type: item["FillType"],
      limit: item["Limit"],
      commision: item["CommissionPaid"],
      price_per_unit: item["PricePerUnit"],
      status: OrderStatus.new(item),
      cancelation_initiated: item["CancelInitiated"],
      immediate_or_cancel: item["ImmediateOrCancel"],
      condition: OrderCondition.new(item),
      market: Market.new(item["Exchange"])
    }
  end

  defp get_order_id(item) do
    item["OrderUuid"] || item["Uuid"] || item["uuid"]
  end

  defp get_price(item) do
    item["Rate"] || item["Price"]
  end
end
