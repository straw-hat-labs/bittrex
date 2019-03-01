defmodule Bittrex.Client do
  @moduledoc false

  alias Bittrex.HttpRequest

  def send(%HttpRequest{} = request) do
    request
    |> put_default_params()
    |> put_api_sign()
    |> execute_request()
    |> process_response()
    |> format_response()
  end

  defp put_default_params(request) do
    params = [apikey: Bittrex.api_key(), nonce: Bittrex.nonce()]

    HttpRequest.put_params(request, params)
  end

  defp put_api_sign(request) do
    apisign =
      request
      |> HttpRequest.full_url()
      |> Bittrex.get_api_sign()

    HttpRequest.put_header(request, apisign: apisign)
  end

  defp execute_request(request) do
    HTTPoison.request(request.method, request.url, "", request.headers, params: request.params)
  end

  defp process_response({:ok, %HTTPoison.Response{status_code: 200, body: body} = _response}) do
    decode_response(body)
  end

  defp process_response({:ok, %HTTPoison.Response{status_code: status_code} = _response}) do
    {:error, status_code}
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

  defp format_response({:ok, data}) do
    case data["success"] do
      true -> {:ok, data["result"]}
      false -> {:error, data["message"]}
    end
  end

  defp format_response({:error, reason}), do: {:error, reason}
end
