defmodule Bittrex.CurrenciesTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Currencies, Currency}

  test "GET /currencies" do
    currencies_response = build_list(2, :currency_response)
    currencies = Enum.map(currencies_response, &Currency.new/1)
    stub_request(currencies_response)

    assert {:ok, ^currencies} = with_mock_client() |> Currencies.get_currencies()
  end

  test "GET /currencies/{currencySymbol}" do
    currency_response = build(:currency_response)
    currency = Currency.new(currency_response)
    stub_request(currency_response)

    assert {:ok, ^currency} = with_mock_client() |> Currencies.get_currency("BAT")
  end
end
