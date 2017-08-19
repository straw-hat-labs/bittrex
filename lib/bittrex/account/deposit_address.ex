defmodule Bittrex.Account.DepositAddress do
  alias Bittrex.Currency
  alias Bittrex.Account.DepositAddress

  defstruct [:currency, :wallet]

  def new(item) do
    %DepositAddress{
      wallet: item["Address"],
      currency: %Currency{
        name: item["Currency"]
      }
    }
  end
end
