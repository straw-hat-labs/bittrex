defmodule Bittrex.Client do
  @moduledoc """
  HTTP client used to request data from Bittrex server. It safes the credentials
  of your client, this allow you to have multiple clients.
  """

  alias Bittrex.Client.Request
  alias StrawHat.Response

  @typedoc """
  The error could be either an string with the reason of the error or a tuple
  with the HTTP status code and the body of the HTTP response.
  """
  @type error :: {integer(), any()} | String.t()

  @http_adapter Application.get_env(:bittrex, :http_adapter, HTTPoison)

  @enforce_keys [:api_key, :api_secret, :sub_account_id]
  defstruct [:api_key, :api_secret, :sub_account_id]

  @doc """
  Creates an HTTP client.
  """
  def new(api_key, api_secret) do
    %__MODULE__{
      api_key: api_key,
      api_secret: api_secret,
      sub_account_id: ""
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
  def send(%Request{} = request) do
    request
    |> Request.put_required_headers()
    |> execute_request()
    |> process_response()
  end

  defp execute_request(request) do
    @http_adapter.request(request.method, request.url, request.body, request.headers,
      params: request.params
    )
  end

  defp process_response({:ok, %{status_code: status_code, body: body} = _response})
       when status_code in 200..299 do
    body
    |> Jason.decode!()
    |> Response.ok()
  end

  defp process_response({:ok, response}) do
    decoded_body =
      response
      |> get_content_type()
      |> decode_body(response.body)

    Response.error({response.status_code, decoded_body})
  end

  defp process_response({:error, %{reason: reason}} = _response) do
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
    body
    |> Jason.decode!()
    |> Bittrex.snake_keys()
  end

  defp decode_body(_content_type, body) do
    body
  end

  defp is_content_type_header({key, _value}) do
    key == "Content-Type"
  end
end
