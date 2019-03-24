defmodule Bittrex.TestSupport.CaseTemplate do
  @moduledoc false

  use ExUnit.CaseTemplate
  import Mox

  @response_headers [{"Content-Type", "application/json"}]

  using do
    quote do
      use ExVCR.Mock
      import Bittrex.TestSupport.CaseTemplate
      import Bittrex.TestSupport.Factory
    end
  end

  def with_mock_client do
    Bittrex.HttpClient.new("apikey", "apisecret")
  end

  def stub_request(data, config \\ %{}) do
    tuple_error = Map.get(config, :tuple_error, :ok)

    stub(
      Bittrex.MockHttpClient,
      :request,
      fn _method, _url, _body, _headers, _options ->
        {tuple_error,
         %{
           status_code: Map.get(config, :status_code, 200),
           body: Jason.encode!(data),
           headers: @response_headers
         }}
      end
    )
  end
end
