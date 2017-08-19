defmodule Bittrex.Account do
  alias Bittrex.Interactor.Account.{
    GetBalances, GetBalance, GetDepositAddress}

  def get_balances do
    GetBalances.call()
  end

  def get_balance(currency) do
    GetBalance.call(currency)
  end

  def get_deposit_address(currency) do
    GetDepositAddress.call(currency)
  end
end
