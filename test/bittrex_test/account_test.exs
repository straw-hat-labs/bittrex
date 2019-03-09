defmodule Bittrex.Test.AccountTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.Account

  test "GET /account" do
    use_cassette "get_account" do
      assert {:ok, account} = with_mock_client() |> Account.get_account()
    end
  end
end
