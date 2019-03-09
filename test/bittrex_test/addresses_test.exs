defmodule Bittrex.Test.AddressesTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.Addresses

  test "GET /addresses" do
    use_cassette "get_addresses" do
      assert {:ok, account} = with_mock_client() |> Addresses.get_addresses()
    end
  end
end
