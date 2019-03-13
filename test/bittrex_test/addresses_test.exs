defmodule Bittrex.Test.AddressesTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.Addresses

  test "GET /addresses NOT IMPLEMENTED" do
    use_cassette "get_addresses" do
      assert {:error, {_status_code, _body}} = with_mock_client() |> Addresses.get_addresses()
    end
  end
end
