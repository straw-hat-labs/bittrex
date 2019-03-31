defmodule Bittrex.OrdersTest do
  use Bittrex.TestSupport.CaseTemplate, async: true
  alias Bittrex.{Orders, Order, OrderCancelResult}

  test "GET /orders/closed" do
    order_response = build_list(2, :order_response, %{"status" => "CLOSED"})
    orders = Enum.map(order_response, &Order.new/1)

    stub_request(%{body: Jason.encode!(order_response)})

    assert {:ok, ^orders} = Orders.get_closed_orders(@client)
  end

  test "GET /orders/open" do
    order_response = build_list(2, :order_response, %{"status" => "OPEN"})
    orders = Enum.map(order_response, &Order.new/1)

    stub_request(%{body: Jason.encode!(order_response)})

    assert {:ok, ^orders} = Orders.get_open_orders(@client)
  end

  test "GET /orders/{orderId}" do
    order_response = build(:order_response)
    order = Order.new(order_response)

    stub_request(%{body: Jason.encode!(order_response)})

    assert {:ok, ^order} = Orders.get_order(@client, "123")
  end

  test "DELETE /orders/{orderId}" do
    order_cancel_result_response = build(:order_cancel_result_response)
    order_cancel = OrderCancelResult.new(order_cancel_result_response)

    stub_request(%{body: Jason.encode!(order_cancel_result_response)})

    assert {:ok, ^order_cancel} = Orders.cancel_order(@client, "123")
  end

  test "POST /orders" do
    order_response = build(:order_response)
    order = Order.new(order_response)

    stub_request(%{body: Jason.encode!(order_response)})

    assert {:ok, ^order} =
             Orders.create_order(@client, %{
               market_name: "BTC-DASH"
             })
  end
end
