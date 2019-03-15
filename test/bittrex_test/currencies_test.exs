defmodule Bittrex.CurrenciesTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Currencies, Currency}

  test "GET /currencies" do
    use_cassette "get_currencies" do
      assert {:ok, _currencies} = with_mock_client() |> Currencies.get_currencies()
    end
  end

  test "GET /currencies/{currencySymbol}" do
    use_cassette "get_currency" do
      assert {:ok, %Currency{}} = with_mock_client() |> Currencies.get_currency("BAT")
    end
  end
end
