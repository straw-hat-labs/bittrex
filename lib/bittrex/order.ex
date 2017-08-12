defmodule Bittrex.Order do
  alias Bittrex.Order

  defstruct [:id, :quantity, :price, :rate, :type, :total, :fill_type]

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
