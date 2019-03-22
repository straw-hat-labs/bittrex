defmodule Bittrex.AddressesTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  import Mox
  alias Bittrex.{Addresses, Address}

  test "GET /addresses" do
    expect(
      Bittrex.MockHttpClient,
      :request,
      create_response([
        %{
          "status" => "REQUESTED",
          "currencySymbol" => "BTC",
          "cryptoAddress" => "123"
        }
      ])
    )

    assert {:ok,
            [
              %Address{
                status: "REQUESTED",
                currency_symbol: "BTC",
                crypto_address: "123"
              }
            ]} = with_mock_client() |> Addresses.get_addresses()
  end

  test "POST /addresses" do
    expect(
      Bittrex.MockHttpClient,
      :request,
      create_response(%{
        "status" => "REQUESTED",
        "currencySymbol" => "BAT",
        "cryptoAddress" => "123"
      })
    )

    assert {:ok,
            %Address{
              status: "REQUESTED",
              currency_symbol: "BAT",
              crypto_address: "123"
            }} =
             with_mock_client()
             |> Addresses.create_address(%{
               currency_symbol: "BAT"
             })
  end

  test "GET /addresses/{currencySymbol}" do
    expect(
      Bittrex.MockHttpClient,
      :request,
      create_response(%{
        "status" => "REQUESTED",
        "currencySymbol" => "BAT",
        "cryptoAddress" => "123"
      })
    )

    assert {:ok,
            %Address{
              status: "REQUESTED",
              currency_symbol: "BAT",
              crypto_address: "123"
            }} = with_mock_client() |> Addresses.get_address("BAT")
  end
end
