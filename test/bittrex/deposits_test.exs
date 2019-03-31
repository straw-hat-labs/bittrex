defmodule Bittrex.DepositsTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Deposits, Deposit}

  test "GET /deposits" do
    deposits_response = build_list(2, :deposit_response)
    deposits = Enum.map(deposits_response, &Deposit.new/1)

    stub_request(%{body: Jason.encode!(deposits_response)})

    assert {:ok, ^deposits} = Deposits.get_deposits(@client)
  end

  test "GET /deposits/{depositId}" do
    deposit_response = build(:deposit_response)
    deposit = Deposit.new(deposit_response)

    stub_request(%{body: Jason.encode!(deposit_response)})

    assert {:ok, ^deposit} = Deposits.get_deposit(@client, "123")
  end
end
