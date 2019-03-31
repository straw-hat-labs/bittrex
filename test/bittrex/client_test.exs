defmodule Bittrex.ClientTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Client.Request, Client}

  test "handling API error responses" do
    http_request = with_mock_client() |> Request.new()

    stub_request(%{
      body: Jason.encode!(%{"messageResponse" => "Something went wrong"}),
      status_code: 400
    })

    assert {:error, {400, %{"message_response" => "Something went wrong"}}} ==
             Client.send(http_request)
  end

  test "handling non JSON response" do
    http_request = with_mock_client() |> Request.new()

    stub_request(%{
      body: "<p>Some HTML <b>here</b></p>",
      headers: [{"Content-Type", "application/text"}],
      status_code: 500
    })

    assert {:error, {500, "<p>Some HTML <b>here</b></p>"}} == Client.send(http_request)
  end

  test "handling errors" do
    http_request = with_mock_client() |> Request.new()

    stub_request(%{
      tupple_status: :error,
      response: %{reason: "CAPUN"}
    })

    assert {:error, "CAPUN"} == Client.send(http_request)
  end
end
