defmodule Bittrex.Client.RequestTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Client.Request, Client}

  test "add subaccount id to headers" do
    http_request =
      @client
      |> Client.with_sub_account("pepega")
      |> Request.new()

    assert %{
             "Api-Subaccount-Id" => "pepega"
           } == Request.put_api_sub_account_id(%{}, http_request)
  end
end
