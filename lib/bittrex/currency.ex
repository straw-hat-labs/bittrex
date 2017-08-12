defmodule Bittrex.Currency do
  alias Bittrex.Interactor.Currency.{GetCurrencies}

  defstruct [:code, :name, :active, :transaction_fee, :minimum_confirmation,
             :coin_type, :base_address]

  def get_currencies do
    GetCurrencies.call()
  end
end
