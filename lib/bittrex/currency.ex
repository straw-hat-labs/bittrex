defmodule Bittrex.Currency do
  alias Bittrex.Currency
  alias Bittrex.Interactor.Currency.{GetCurrencies}

  defstruct [:code, :name, :active, :transaction_fee, :minimum_confirmation,
             :coin_type, :base_address]

  def get_currencies do
    GetCurrencies.call()
  end

  def new(item) do
    %Currency{
      code: item["Currency"],
      name: item["CurrencyLong"],
      active: item["IsActive"],
      transaction_fee: item["TxFee"],
      minimum_confirmation: item["MinConfirmation"],
      coin_type: item["CoinType"],
      base_address: item["BaseAddress"]
    }
  end
end
