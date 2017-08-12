defmodule Bittrex.Order do
  alias Bittrex.Interactor.Order.{CancelOrder}
  alias Bittrex.Order

  defstruct [:id, :quantity, :price, :rate, :type, :total, :fill_type]

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
      id: item["Id"] || item["uuid"],
      quantity: item["Quantity"],
      price: item["Price"],
      total: item["Total"],
      rate: item["Rate"],
      fill_type: item["FillType"],
      type: type
    }
  end
end
