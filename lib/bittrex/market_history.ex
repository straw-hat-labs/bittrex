defmodule Bittrex.MarketHistory do
  @moduledoc """
  Market History entity.
  """

  alias Bittrex.{MarketHistory, Order}

  defstruct [:id, :order]

  def new(item) do
    %MarketHistory{
      id: item["Id"],
      order: Order.new(item)
    }
  end
end
