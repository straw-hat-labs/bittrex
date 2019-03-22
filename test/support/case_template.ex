defmodule Bittrex.TestSupport.CaseTemplate do
  @moduledoc false

  use ExUnit.CaseTemplate

  @response_headers [{"Content-Type", "application/json"}]

  using do
    quote do
      use ExVCR.Mock
      import Bittrex.TestSupport.CaseTemplate
    end
  end

  def with_mock_client do
    Bittrex.HttpClient.new("apikey", "apisecret")
  end

  def create_response(data, config \\ %{}) do
    {:ok, %{
      status_code: Map.get(config, :status_code, 200),
      body: Jason.encode!(data),
      headers: @response_headers
    }}
  end
end
