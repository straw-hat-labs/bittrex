defmodule Bittrex.HttpClient do
  alias Bittrex.HttpRequest

  @enforce_keys [:api_key, :api_secret]
  defstruct [:api_key, :api_secret, :sub_account_id]

  def new(api_key, api_secret) do
    %__MODULE__{
      api_key: api_key,
      api_secret: api_secret
    }
  end

  def with_sub_account(http_client, sub_account_id) do
    Map.put(http_client, :sub_account_id, sub_account_id)
  end

  @doc false
  def send(%HttpRequest{} = request) do
    request
    |> HttpRequest.put_required_headers()
    |> execute_request()
    |> process_response()
  end

  defp execute_request(request) do
    headers = Enum.into(request.headers, [])
    HTTPoison.request(request.method, request.url, request.body, headers, params: request.params)
  end

  defp process_response({:ok, %HTTPoison.Response{status_code: 200, body: body} = _response}) do
    decode_response(body)
  end

  defp process_response(
         {:ok, %HTTPoison.Response{status_code: status_code, body: body} = _response}
       ) do
    {:error, status_code, body}
  end

  defp process_response({:error, %HTTPoison.Error{reason: reason}} = _response) do
    {:error, reason}
  end

  defp decode_response(body) do
    case Jason.decode(body) do
      {:ok, data} -> {:ok, data}
      _ -> {:error, :decoding_body_failed}
    end
  end
end
