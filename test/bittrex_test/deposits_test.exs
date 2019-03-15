defmodule Bittrex.DepositsTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.Deposits

  test "GET /deposits" do
    use_cassette "get_deposits" do
      assert {:ok, _deposits} = with_mock_client() |> Deposits.get_deposits()
    end
  end

  test "GET /deposits/pending" do
    use_cassette "get_pending_deposits" do
      assert {:ok, _deposits} = with_mock_client() |> Deposits.get_pending_deposits()
    end
  end

  test "GET /deposits/{depositId} (NOT YET IMPLEMENTED)" do
    use_cassette "get_deposit" do
      assert {:error, {_status_code, _body}} = with_mock_client() |> Deposits.get_deposit("BAT")
    end
  end
end
