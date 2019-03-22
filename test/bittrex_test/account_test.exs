defmodule Bittrex.AccountTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  import Mox
  alias Bittrex.Account

  test "GET /account" do
    stub(
      Bittrex.MockHttpClient,
      :request,
      create_response(%{
        "id" => "123",
        "email" => "acmec@acmec.com",
        "isInternational" => true,
        "isFiat" => true
      })
    )

    assert {:ok, %Account{}} = with_mock_client() |> Account.get_account()
  end
end
