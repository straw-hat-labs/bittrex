defmodule Bittrex.Test.AddressesTest do
  use ExUnit.Case
  alias Bittrex.{HttpClient, Addresses}

  @api_key System.get_env("BITTREX_KEY")
  @api_secret System.get_env("BITTREX_SECRET")
  @client HttpClient.new(@api_key, @api_secret)

  test "GET /addresses" do
    assert {:ok, account} = Addresses.get_addresses(@client)
  end
end
