defmodule Bittrex.Order.OrderStatus do
  alias Bittrex.Order.OrderStatus

  defstruct [:name, :at]

  def new(%{"Opened": nil} = order) do
    %OrderStatus{
      name: "closed",
      at: Bittrex.format_datetime(order["Closed"])
    }
  end
  def new(order) do
    %OrderStatus{
      name: "opened",
      at: Bittrex.format_datetime(order["Opened"])
    }
  end
end
