defmodule Bittrex.AccountTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  import Mox
  alias Bittrex.Account

  @response_headers [{"Content-Type", "application/json"}]

  defp account do
    %{
      "id" => "123",
      "email" => "acmec@acmec.com",
      "isInternational" => true,
      "isFiat" => true
    }
  end

  test "GET /account" do
    expect(Bittrex.MockHttpClient, :request, fn _method, _url, _body, _headers, _options ->
      account() |> create_response()
    end)

    assert {:ok, %Account{}} = with_mock_client() |> Account.get_account()
  end
end
