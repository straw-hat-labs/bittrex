defmodule Bittrex.CurrenciesTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  import Mox
  alias Bittrex.{Currencies, Currency}

  test "GET /currencies" do
    stub_request([
      %{
        "symbol" => "BTC",
        "name" => "Bitcoin",
        "baseAddress" => "123",
        "coinType" => "pepega",
        "status" => "ONLINE",
        "isInternational" => true,
        "minConfirmations" => 123_324_343,
        "notice" => "some alert or news",
        "txFee" => 10.5
      }
    ])

    assert {:ok,
            [
              %Currency{
                symbol: "BTC",
                name: "Bitcoin",
                base_address: "123",
                coin_type: "pepega",
                status: "ONLINE",
                is_international: true,
                min_confirmations: 123_324_343,
                notice: "some alert or news",
                tx_fee: 10.5
              }
            ]} = with_mock_client() |> Currencies.get_currencies()
  end

  test "GET /currencies/{currencySymbol}" do
    stub_request(%{
      "symbol" => "BAT",
      "name" => "Bitcoin",
      "baseAddress" => "123",
      "coinType" => "pepega",
      "status" => "ONLINE",
      "isInternational" => true,
      "minConfirmations" => 123_324_343,
      "notice" => "some alert or news",
      "txFee" => 10.5
    })

    assert {:ok,
            %Currency{
              symbol: "BAT",
              name: "Bitcoin",
              base_address: "123",
              coin_type: "pepega",
              status: "ONLINE",
              is_international: true,
              min_confirmations: 123_324_343,
              notice: "some alert or news",
              tx_fee: 10.5
            }} = with_mock_client() |> Currencies.get_currency("BAT")
  end
end
