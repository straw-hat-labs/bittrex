defmodule Bittrex.BalancesTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  import Mox
  alias Bittrex.{Balances, Balance}

  test "GET /balances" do
    stub_request([
      %{
        "currencySymbol" => "BTC",
        "total" => 12.0,
        "available" => 5
      }
    ])

    assert {:ok,
            [
              %Balance{
                currency_symbol: "BTC",
                total: 12.0,
                available: 5
              }
            ]} = with_mock_client() |> Balances.get_balances()
  end

  test "GET /balances/{currencySymbol}" do
    stub_request(%{
      "currencySymbol" => "BTC",
      "total" => 12.0,
      "available" => 5
    })

    assert {:ok,
            %Balance{
              currency_symbol: "BTC",
              total: 12.0,
              available: 5
            }} = with_mock_client() |> Balances.get_balance("BAT")
  end
end
