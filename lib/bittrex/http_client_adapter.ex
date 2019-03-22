defmodule Bittrex.HttpClientAdapter do
  @moduledoc """
  The HTTP client adapter.
  """

  @type method :: :get | :post | :put | :patch | :delete | :options | :head
  @type headers :: %{binary => binary}
  @type url :: binary | any
  @type body :: binary
  @type params :: map
  @type options :: keyword | any
  @type response :: %{
          status_code: integer,
          body: term,
          headers: list
        }
  @type error_response :: %{reason: any}

  @callback request(method, url, body, headers, options) ::
              {:ok, response} | {:error, error_response}
end
