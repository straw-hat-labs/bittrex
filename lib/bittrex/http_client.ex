defmodule Bittrex.HttpClient do
  @moduledoc """
  HTTP client used to request data from Bittrex server. It safes the credentials
  of your client, this allow you to have multiple clients.
  """

  alias Bittrex.HttpRequest
  alias StrawHat.Response

  @enforce_keys [:api_key, :api_secret]
  defstruct [:api_key, :api_secret, :sub_account_id]

  def new(api_key, api_secret) do
    %__MODULE__{
      api_key: api_key,
      api_secret: api_secret
    }
  end

  @doc """
  Add Sub account to your HTTP client credentials. Read more about Sub Accounts
  in Bittrex documentation.
  """
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

  defp process_response({:ok, %HTTPoison.Response{status_code: status_code, body: body} = _response}) when status_code in 200..299 do
    body
    |> Jason.decode!()
    |> Response.ok()
  end

  defp process_response({:ok, %HTTPoison.Response{} = response}) do
    decoded_body =
      response
      |> get_content_type()
      |> decode_body(response.body)

    Response.error({response.status_code, decoded_body})
  end

  defp process_response({:error, %HTTPoison.Error{reason: reason}} = _response) do
    Response.error(reason)
  end

  defp get_content_type(response) do
    {_key, content_type} = Enum.find(response.headers, &is_content_type_header/1)

    if String.contains?(content_type, "application/json") do
      :json
    else
      :text
    end
  end

  defp decode_body(:json, body) do
    Jason.decode!(body)
  end

  defp decode_body(_content_type, body) do
    body
  end

  defp is_content_type_header({key, _value}) do
    key == "Content-Type"
  end
end
