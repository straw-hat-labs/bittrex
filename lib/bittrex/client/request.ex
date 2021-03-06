defmodule Bittrex.Client.Request do
  @moduledoc false

  @base_url "https://api.bittrex.com/v3"
  @default_headers %{"Content-Type" => "application/json"}

  defstruct [:client, :method, :url, :headers, :params, :body]

  def new(client) do
    %__MODULE__{
      client: client,
      headers: %{},
      params: %{},
      body: ""
    }
  end

  def put_method(%__MODULE__{} = http_request, method) do
    Map.put(http_request, :method, method)
  end

  def put_path(%__MODULE__{} = http_request, path) do
    url = @base_url <> path
    Map.put(http_request, :url, url)
  end

  def put_body(%__MODULE__{} = http_request, body) do
    new_body =
      body
      |> Bittrex.camelcase_keys()
      |> Jason.encode!()

    Map.put(http_request, :body, new_body)
  end

  def put_headers(%__MODULE__{} = request, headers) do
    headers = Map.merge(request.headers, headers)
    Map.put(request, :headers, headers)
  end

  def put_params(%__MODULE__{} = request, params) do
    normalized_params = Bittrex.camelcase_keys(params)
    new_params = Map.merge(request.params, normalized_params)

    Map.put(request, :params, new_params)
  end

  def put_required_headers(request) do
    headers =
      @default_headers
      |> put_api_key_header(request)
      |> put_api_timestamp_header()
      |> put_api_content_hash_header(request)
      |> put_api_sub_account_id(request)
      |> put_api_signature_header(request)

    put_headers(request, headers)
  end

  def put_api_sub_account_id(headers, request) do
    if request.client.sub_account_id == "" do
      headers
    else
      Map.put(headers, "Api-Subaccount-Id", request.client.sub_account_id)
    end
  end

  defp put_api_signature_header(headers, request) do
    method =
      request.method
      |> to_string()
      |> String.upcase()

    pre_sign =
      "#{headers["Api-Timestamp"]}#{request.url}#{method}#{headers["Api-Content-Hash"]}#{
        request.client.sub_account_id
      }"

    signature =
      :sha512
      |> :crypto.hmac(request.client.api_secret, pre_sign)
      |> Base.encode16(case: :lower)

    Map.put(headers, "Api-Signature", signature)
  end

  defp put_api_key_header(headers, request) do
    Map.put(headers, "Api-Key", request.client.api_key)
  end

  defp put_api_timestamp_header(headers) do
    timestamp = :os.system_time(:milli_seconds)
    Map.put(headers, "Api-Timestamp", timestamp)
  end

  defp put_api_content_hash_header(headers, request) do
    content_hash =
      :sha512
      |> :crypto.hash(request.body)
      |> Base.encode16(case: :lower)

    Map.put(headers, "Api-Content-Hash", content_hash)
  end
end
