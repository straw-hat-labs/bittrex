defmodule Bittrex.DepositsTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Deposits, Deposit}

  test "GET /deposits" do
    use_cassette "get_deposits" do
      assert {:ok, _deposits} = with_mock_client() |> Deposits.get_deposits()
    end
  end

  test "GET /deposits/{depositId}" do
    use_cassette "get_deposit" do
      assert {:ok, %Deposit{}} =
               with_mock_client() |> Deposits.get_deposit("da1e1640-ea44-40ae-ac5a-6a4843305b70")
    end
  end
end
