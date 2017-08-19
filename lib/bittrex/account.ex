defmodule Bittrex.Account do
  alias Bittrex.Interactor.Account.{
    GetBalances, GetBalance, GetDepositAddress, Withdraw}

  def get_balances do
    GetBalances.call()
  end

  def get_balance(currency) do
    GetBalance.call(currency)
  end

  def get_deposit_address(currency) do
    GetDepositAddress.call(currency)
  end

  def withdraw(currency, quantity, address, paymentid) do
    Withdraw.call(currency, quantity, address, paymentid)
  end
end
