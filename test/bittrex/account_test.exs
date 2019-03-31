defmodule Bittrex.AccountTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.Account

  test "GET /account" do
    account_response = build(:account_response)
    account = Account.new(account_response)

    stub_request(%{body: Jason.encode!(account_response)})

    assert {:ok, ^account} = Account.get_account(@client)
  end
end
