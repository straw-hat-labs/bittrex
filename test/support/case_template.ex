defmodule Bittrex.TestSupport.CaseTemplate do
  @moduledoc false

  use ExUnit.CaseTemplate
  import Mox

  @response_headers [{"Content-Type", "application/json"}]

  using do
    quote do
      import Bittrex.TestSupport.CaseTemplate
      import Bittrex.TestSupport.Factory
    end
  end

  def with_mock_client do
    Bittrex.HttpClient.new("apikey", "apisecret")
  end

  def stub_request(config) do
    tupple_status = Map.get(config, :tupple_status, :ok)
    headers = Map.get(config, :headers, @response_headers)

    response =
      Map.get(config, :response, %{
        status_code: Map.get(config, :status_code, 200),
        body: Map.get(config, :body, ""),
        headers: headers
      })

    stub(
      Bittrex.MockHttpClient,
      :request,
      fn _method, _url, _body, _headers, _options ->
        {tupple_status, response}
      end
    )
  end
end
