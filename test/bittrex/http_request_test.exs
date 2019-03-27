defmodule Bittrex.HttpRequestTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{HttpRequest, HttpClient}

  test "add subaccount id to headers" do
    http_request =
      with_mock_client()
      |> HttpClient.with_sub_account("pepega")
      |> HttpRequest.new()

    assert %{
             "Api-Subaccount-Id" => "pepega"
           } == HttpRequest.put_api_sub_account_id(%{}, http_request)
  end
end
