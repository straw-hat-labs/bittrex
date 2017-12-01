defmodule Bittrex.Account.AccountBalance do
  alias Bittrex.Currency
  alias Bittrex.Account.AccountBalance

  defstruct [:id, :currency, :balance, :available, :pending, :wallet, :requested]

  def new(item) do
    %AccountBalance{
      id: item["Uuid"],
      balance: item["Balance"],
      available: item["Available"],
      pending: item["Pending"],
      wallet: item["CryptoAddress"],
      requested: item["Requested"],
      currency: %Currency{
        name: item["Currency"]
      }
    }
  end
end
