defmodule Bittrex.ClientTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Client, Client.Request, Client.Error}

  test "handling API error responses" do
    http_request = with_mock_client() |> Request.new()

    error = %Error{
      status_code: 400,
      reason: %{"message_response" => "Something went wrong"}
    }

    stub_request(%{
      body: Jason.encode!(%{"messageResponse" => "Something went wrong"}),
      status_code: 400
    })

    assert {:error, error} == Client.send(http_request)
  end

  test "handling non JSON response" do
    http_request = with_mock_client() |> Request.new()

    error = %Error{
      status_code: 500,
      reason: "<p>Some HTML <b>here</b></p>"
    }

    stub_request(%{
      body: "<p>Some HTML <b>here</b></p>",
      headers: [{"Content-Type", "application/text"}],
      status_code: 500
    })

    assert {:error, error} == Client.send(http_request)
  end
end
