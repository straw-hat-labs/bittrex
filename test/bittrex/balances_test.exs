defmodule Bittrex.BalancesTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Balances, Balance}

  test "GET /balances" do
    balances_response = build_list(2, :balance_response)
    balances = Enum.map(balances_response, &Balance.new/1)

    stub_request(%{body: Jason.encode!(balances_response)})

    assert {:ok, ^balances} = Balances.get_balances(@client)
  end

  test "GET /balances/{currencySymbol}" do
    balance_response = build(:balance_response)
    balance = Balance.new(balance_response)

    stub_request(%{body: Jason.encode!(balance_response)})

    assert {:ok, ^balance} = Balances.get_balance(@client, "BAT")
  end
end
