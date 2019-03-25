defmodule Bittrex.AddressesTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Addresses, Address}

  test "GET /addresses" do
    addresses_response = build_list(2, :address_response)
    addresses = Enum.map(addresses_response, &Address.new/1)

    stub_request(%{
      body: Jason.encode!(addresses_response)
    })

    assert {:ok, ^addresses} = with_mock_client() |> Addresses.get_addresses()
  end

  test "POST /addresses" do
    address_response = build(:address_response)
    address = Address.new(address_response)

    stub_request(%{
      body: Jason.encode!(address_response)
    })

    assert {:ok, ^address} =
             with_mock_client()
             |> Addresses.create_address(%{currency_symbol: "BAT"})
  end

  test "GET /addresses/{currencySymbol}" do
    address_response = build(:address_response)
    address = Address.new(address_response)

    stub_request(%{
      body: Jason.encode!(address_response)
    })

    assert {:ok, ^address} = with_mock_client() |> Addresses.get_address("BAT")
  end
end
