defmodule Bittrex.Order do
  alias Bittrex.Order

  defstruct [:quantity, :rate, :type]

  def new(type, item) do
    %Order{
      quantity: item["Quantity"],
      rate: item["Rate"],
      type: type
    }
  end
end
