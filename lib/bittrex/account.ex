defmodule Bittrex.Account do
  alias Bittrex.Interactor.Account.{GetBalances, GetBalance}

  def get_balances do
    GetBalances.call()
  end

  def get_balance(currency) do
    GetBalance.call(currency)
  end
end
