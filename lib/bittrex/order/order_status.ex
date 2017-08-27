defmodule Bittrex.Order.OrderStatus do
  alias Bittrex.Order.OrderStatus

  defstruct [:name, :at]

  def new(%{"Closed" => closed_at} = order) do
    %OrderStatus{
      name: "CLOSED",
      at: Bittrex.format_datetime(closed_at)
    }
  end
  def new(%{"Opened" => opened_at} = order) do
    %OrderStatus{
      name: "OPENED",
      at: Bittrex.format_datetime(opened_at)
    }
  end
end
