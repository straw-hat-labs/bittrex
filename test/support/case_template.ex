defmodule Bittrex.TestSupport.CaseTemplate do
  @moduledoc false

  use ExUnit.CaseTemplate

  @api_key System.get_env("BITTREX_KEY")
  @api_secret System.get_env("BITTREX_SECRET")

  using do
    quote do
      use ExVCR.Mock
      import Bittrex.TestSupport.CaseTemplate
    end
  end

  setup tags do
    ExVCR.Config.response_headers_blacklist([])
    ExVCR.Config.cassette_library_dir("test/support/fixtures")
    :ok
  end

  def with_mock_client do
    Bittrex.HttpClient.new(@api_key, @api_secret)
  end
end
