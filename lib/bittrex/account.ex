defmodule Bittrex.Account do
  alias Bittrex.Interactor.Account.{GetBalances}

  def get_balances do
    GetBalances.call()
  end
end
