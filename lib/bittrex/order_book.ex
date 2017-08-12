defmodule Bittrex.OrderBook do
  alias Bittrex.Interactor.OrderBook.{GetOrderBook}
  alias Bittrex.{Order, OrderBook}

  defstruct [:buys, :sells]

  def get_order_book(market_name, type) do
    GetOrderBook.call(market_name, type)
  end

  def new(buys, sells) do
    %OrderBook{
      buys: list_of_orders(buys, "buy"),
      sells: list_of_orders(sells, "sell")
    }
  end

  def list_of_orders(list, type) do
    list
    |> Enum.map(fn item -> Order.new(type, item) end)
  end
end
