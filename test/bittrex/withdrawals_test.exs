defmodule Bittrex.WithdrawalsTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Withdrawals, Withdrawal}

  test "GET /withdrawals" do
    withdrawals_response = build_list(2, :withdrawal_response)
    withdrawals = Enum.map(withdrawals_response, &Withdrawal.new/1)

    stub_request(%{body: Jason.encode!(withdrawals_response)})

    assert {:ok, ^withdrawals} = Withdrawals.get_withdrawals(@client)
  end

  test "GET /withdrawals/{withdrawalId}" do
    withdrawal_response = build(:withdrawal_response)
    withdrawal = Withdrawal.new(withdrawal_response)

    stub_request(%{body: Jason.encode!(withdrawal_response)})

    assert {:ok, ^withdrawal} = Withdrawals.get_withdrawal(@client, "123")
  end

  test "DELETE /withdrawals/{withdrawalId}" do
    stub_request(%{body: Jason.encode!("object")})

    assert {:ok, "object"} = Withdrawals.delete_withdrawal(@client, "123")
  end

  test "POST /withdrawals" do
    withdrawal_response = build(:withdrawal_response)
    withdrawal = Withdrawal.new(withdrawal_response)

    stub_request(%{body: Jason.encode!(withdrawal_response)})

    assert {:ok, ^withdrawal} =
             Withdrawals.create_withdrawal(@client, %{
               currency_symbol: "BAT",
               quantity: 125.5,
               address: "1236"
             })
  end
end
