defmodule Bittrex.DepositsTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Deposits, Deposit}

  @date_unix "1553243950205"
  @date Bittrex.format_datetime(@date_unix)

  test "GET /deposits" do
    stub_request([
      %{
        "id" => "123",
        "currencySymbol" => "BTC",
        "quantity" => 123.23,
        "address" => "123adresses",
        "txId" => "pepegatax",
        "confirmations" => 1235,
        "createdAt" => @date_unix,
        "updatedAt" => @date_unix,
        "status" => "COMPLETED"
      }
    ])

    assert {:ok,
            [
              %Deposit{
                id: "123",
                currency_symbol: "BTC",
                quantity: 123.23,
                address: "123adresses",
                tx_id: "pepegatax",
                confirmations: 1235,
                created_at: @date,
                updated_at: @date,
                status: "COMPLETED"
              }
            ]} = with_mock_client() |> Deposits.get_deposits()
  end

  test "GET /deposits/{depositId}" do
    stub_request(%{
      "id" => "123",
      "currencySymbol" => "BTC",
      "quantity" => 123.23,
      "address" => "123adresses",
      "txId" => "pepegatax",
      "confirmations" => 1235,
      "createdAt" => @date_unix,
      "updatedAt" => @date_unix,
      "status" => "COMPLETED"
    })

    assert {:ok,
            %Deposit{
              id: "123",
              currency_symbol: "BTC",
              quantity: 123.23,
              address: "123adresses",
              tx_id: "pepegatax",
              confirmations: 1235,
              created_at: @date,
              updated_at: @date,
              status: "COMPLETED"
            }} =
             with_mock_client() |> Deposits.get_deposit("da1e1640-ea44-40ae-ac5a-6a4843305b70")
  end
end
