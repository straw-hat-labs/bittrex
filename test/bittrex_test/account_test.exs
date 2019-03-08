defmodule Bittrex.Test.AccountTests do
  use ExUnit.Case
  alias Bittrex.{HttpClient, Account}

  test "getting an account" do
    client = HttpClient.new("123", "645")
    assert {:ok, account} = Account.get_account(client)
  end
end
