defmodule Bittrex.HttpClient do
  alias Bittrex.HttpRequest

  @enforce_keys [:api_key, :api_secret]
  defstruct [:api_key, :api_secret]

  def new(api_key, api_secret) do
    %__MODULE__{
      api_key: api_key,
      api_secret: api_secret
    }
  end

  def send(%HttpRequest{} = request) do
    request
    |> put_default_params()
    |> execute_request()
    |> process_response()
  end

  defp put_default_params(request) do
    timestamp = DateTime.utc_now() |> DateTime.to_unix(:millisecond)
    content_hash = :crypto.hash(:sha256, "")
    params = %{
      "Api-Key" => request.http_client.api_key,
      "Api-Timestamp" => timestamp,
      "Api-Content-Hash" => content_hash,
      "Api-Signature" => api_signature(request, timestamp, content_hash)
    }

    HttpRequest.put_params(request, params)
  end

  defp api_signature(request, timestamp, content_hash) do
    IO.inspect(request)
    pre_sign = "#{timestamp}#{request.url}#{content_hash}" |> IO.inspect()
    :crypto.hmac(:sha512, request.http_client.api_key, pre_sign)
  end

  defp execute_request(request) do
    HTTPoison.request(request.method, request.url, "", request.headers, params: request.params)
  end

  defp process_response({:ok, %HTTPoison.Response{status_code: 200, body: body} = _response}) do
    decode_response(body)
  end

  defp process_response({:ok, %HTTPoison.Response{status_code: status_code, body: body} = _response}) do
    {:error, status_code, body}
  end

  defp process_response({:error, %HTTPoison.Error{reason: reason}} = _response) do
    {:error, reason}
  end

  defp decode_response(body) do
    case Jason.decode(body) do
      {:ok, data} -> {:ok, data}
      _ -> {:error, "can't decode the response body"}
    end
  end
end
