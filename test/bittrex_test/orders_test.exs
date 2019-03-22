defmodule Bittrex.OrdersTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Orders, Order, OrderCancelResult}

  test "GET /orders/closed" do
    use_cassette "get_closed_orders" do
      assert {:ok, _orders} = with_mock_client() |> Orders.get_closed_orders()
    end
  end

  test "GET /orders/open" do
    use_cassette "get_open_orders" do
      assert {:ok, _orders} = with_mock_client() |> Orders.get_open_orders()
    end
  end

  test "GET /orders/{orderId}" do
    use_cassette "get_order" do
      assert {:ok, %Order{}} =
               with_mock_client() |> Orders.get_order("d153cd02-5c95-4691-ab9e-0d30564bef02")
    end
  end

  test "DELETE /orders/{orderId}" do
    use_cassette "cancel_order" do
      assert {:ok, %OrderCancelResult{}} =
               with_mock_client() |> Orders.cancel_order("d153cd02-5c95-4691-ab9e-0d30564bef02")
    end
  end

  test "POST /orders" do
    use_cassette "create_order" do
      assert {:ok, %Order{}} =
               with_mock_client() |> Orders.create_order(%{
                market_name: "BTC-DASH"
               })
    end
  end
end
