defmodule BittrexTest.HttpRequestTest do
  use ExUnit.Case
  alias Bittrex.HttpRequest

  test "process_url/1" do
    url = HttpRequest.process_url("/test")

    assert url == "https://bittrex.com/api/v1.1/test"
  end

  test "full_url/1" do
    full_url =
      HttpRequest.new(:get, "/test", [apikey: "1235"])
      |> HttpRequest.full_url()

    assert full_url == "https://bittrex.com/api/v1.1/test?apikey=1235"
  end

  test "put_header/1" do
    request =
      HttpRequest.new(:get, "/test", [], [authorization: "bearer 123"])
      |> HttpRequest.put_header([apikey: "123"])

    assert request.headers == [authorization: "bearer 123", apikey: "123"]
  end

  test "put_params/1" do
    request =
      HttpRequest.new(:get, "/test", [nonce: "123"], [])
      |> HttpRequest.put_params([apikey: "123"])

    assert request.params == [nonce: "123", apikey: "123"]
  end
end
