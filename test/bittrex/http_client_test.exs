defmodule Bittrex.HttpClientTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{HttpRequest, HttpClient}

  test "handling API error responses" do
    http_request = with_mock_client() |> HttpRequest.new()
    stub_request(%{
      body: Jason.encode!(%{ "messageResponse" => "Something went wrong" }),
      status_code: 400
    })

    assert {:error, {400, %{"message_response" => "Something went wrong"}}} == HttpClient.send(http_request)
  end

  test "handling non JSON response" do
    http_request = with_mock_client() |> HttpRequest.new()

    stub_request(%{
      body: "<p>Some HTML <b>here</b></p>",
      headers: [{"Content-Type", "application/text"}],
      status_code: 400
    })

    assert {:error, {500, "<p>Some HTML <b>here</b></p>"}} == HttpClient.send(http_request)
  end

  test "handling errors" do
    http_request = with_mock_client() |> HttpRequest.new()

    stub_request(%{
      tupple_status: :error,
      response: %{reason: "CAPUN"}
    })

    assert {:error, "CAPUN"} == HttpClient.send(http_request)
  end
end
