defmodule Bittrex.StatusTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Status, ServiceStatus}

  test "GET /status" do
    stub_request(%{
      "status" => "123",
      "serverTime" => 12_351_243
    })

    assert {:ok,
            %ServiceStatus{
              status: "123",
              server_time: 12_351_243
            }} = with_mock_client() |> Status.get_status()
  end
end
