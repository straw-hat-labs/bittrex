defmodule Bittrex.DepositsTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Deposits, Deposit}

  test "GET /deposits" do
    deposits_response = build_list(2, :deposit_response)
    deposits = Enum.map(deposits_response, &Deposit.new/1)
    stub_request(deposits_response)

    assert {:ok, ^deposits} = with_mock_client() |> Deposits.get_deposits()
  end

  test "GET /deposits/{depositId}" do
    deposit_response = build(:deposit_response)
    deposit = Deposit.new(deposit_response)
    stub_request(deposit_response)

    assert {:ok, ^deposit} =
             with_mock_client() |> Deposits.get_deposit("123")
  end
end
