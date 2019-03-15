defmodule Bittrex.StatusTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Status, ServiceStatus}

  test "GET /status" do
    use_cassette "get_status" do
      assert {:ok, %ServiceStatus{}} = with_mock_client() |> Status.get_status()
    end
  end
end
