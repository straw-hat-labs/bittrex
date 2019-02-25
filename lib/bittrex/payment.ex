defmodule Bittrex.Payment do
  @moduledoc """
  Payment entity.
  """

  alias Bittrex.{Payment, Currency}

  defstruct [
    :id,
    :currency,
    :amount,
    :opened_at,
    :authorized,
    :pending,
    :transaction,
    :canceled,
    :wallet,
    :invalid_wallet
  ]

  def new(item) do
    %Payment{
      id: get_paymeny_id(item),
      amount: item["Amount"],
      wallet: item["Address"],
      invalid_wallet: item["InvalidAddress"],
      opened_at: Bittrex.format_datetime(item["Opened"]),
      authorized: item["Authorized"],
      pending: item["PendingPayment"],
      canceled: item["Canceled"],
      transaction: %{
        id: item["TxId"],
        fee: item["TxCost"]
      },
      currency: %Currency{
        code: item["Currency"]
      }
    }
  end

  defp get_paymeny_id(item) do
    item["PaymentUuid"] || item["uuid"]
  end
end
