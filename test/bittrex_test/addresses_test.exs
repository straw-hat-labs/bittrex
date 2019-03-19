defmodule Bittrex.AddressesTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Addresses, Address}

  test "GET /addresses" do
    use_cassette "get_addresses" do
      assert {:ok, _addresses} = with_mock_client() |> Addresses.get_addresses()
    end
  end

  test "POST /addresses" do
    use_cassette "create_address" do
      assert {:ok, %Address{}} = with_mock_client() |> Addresses.create_address(%{
        currency_symbol: "BAT"
      })
    end
  end

  test "GET /addresses/{currencySymbol}" do
    use_cassette "get_address" do
      assert {:ok, %Address{}} = with_mock_client() |> Addresses.get_address("BAT")
    end
  end
end
