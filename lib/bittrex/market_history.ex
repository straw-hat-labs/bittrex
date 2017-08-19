defmodule Bittrex.MarketHistory do
  alias Bittrex.{MarketHistory, Order}

  defstruct [:id, :order]

  def new(item) do
    %MarketHistory{
      id: item["Id"],
      order: Order.new(item)
    }
  end
end
