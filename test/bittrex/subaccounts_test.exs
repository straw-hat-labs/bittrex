defmodule Bittrex.SubaccountsTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Subaccounts, Subaccount}

  test "GET /subaccounts" do
    subaccount_response = build_list(2, :subaccount_response)
    subaccounts = Enum.map(subaccount_response, &Subaccount.new/1)

    stub_request(%{body: Jason.encode!(subaccount_response)})

    assert {:ok, ^subaccounts} = Subaccounts.get_subaccounts(@client)
  end

  test "POST /subaccounts" do
    subaccount_response = build(:subaccount_response)
    subaccount = Subaccount.new(subaccount_response)

    stub_request(%{body: Jason.encode!(subaccount_response)})

    assert {:ok, ^subaccount} = Subaccounts.create_subaccount(@client, %{})
  end

  test "GET /subaccounts/{subaccountId}" do
    subaccount_response = build(:subaccount_response)
    subaccount = Subaccount.new(subaccount_response)

    stub_request(%{body: Jason.encode!(subaccount_response)})

    assert {:ok, ^subaccount} = Subaccounts.get_subaccount(@client, "123")
  end
end
