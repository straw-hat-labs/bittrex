defmodule Bittrex.StatusTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Status, ServiceStatus}

  test "GET /status" do
    service_status_response = build(:service_status_response)
    service_status = ServiceStatus.new(service_status_response)

    stub_request(%{
      body: Jason.encode!(service_status_response)
    })

    assert {:ok, ^service_status} = with_mock_client() |> Status.get_status()
  end
end
