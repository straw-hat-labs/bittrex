defmodule Bittrex.BalancesTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Balances, Balance}

  test "POST /balances" do
    use_cassette "get_balances" do
      assert {:ok, _balances} = with_mock_client() |> Balances.get_balances()
    end
  end

  test "GET /balances/{currencySymbol}" do
    use_cassette "get_balance" do
      assert {:ok, %Balance{}} = with_mock_client() |> Balances.get_balance("BAT")
    end
  end
end
