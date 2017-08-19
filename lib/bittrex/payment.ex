defmodule Bittrex.Payment do
  alias Bittrex.Payment

  defstruct [:id]

  def new(item) do
    %Payment{
      id: item["uuid"]
    }
  end
end
