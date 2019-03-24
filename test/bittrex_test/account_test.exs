defmodule Bittrex.AccountTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.Account

  test "GET /account" do
    account_response = build(:account_response)
    account = Account.new(account_response)
    stub_request(account_response)

    assert {:ok, ^account} = with_mock_client() |> Account.get_account()
  end
end
