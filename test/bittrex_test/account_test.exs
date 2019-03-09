defmodule Bittrex.Test.AccountTest do
  use ExUnit.Case
  alias Bittrex.{HttpClient, Account}

  @api_key System.get_env("BITTREX_KEY")
  @api_secret System.get_env("BITTREX_SECRET")
  @client HttpClient.new(@api_key, @api_secret)

  test "GET /account" do
    assert {:ok, account} = Account.get_account(@client)
  end
end
