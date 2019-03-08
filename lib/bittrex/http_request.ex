defmodule Bittrex.HttpRequest do
  @base_url Application.get_env(:bittrex, :base_url, "https://api.bittrex.com/v3")

  @enforce_keys [:http_client, :method, :url, :headers, :params]
  defstruct [:http_client, :method, :url, :headers, :params]

  def new(http_client, method, path, params \\ %{}, headers \\ %{}) do
    %__MODULE__{
      http_client: http_client,
      method: method,
      url: process_url(path),
      params: params,
      headers: headers
    }
  end

  def process_url(path) do
    @base_url <> path
  end

  def put_header(%__MODULE__{} = request, headers) do
    headers = Map.merge(request.headers, headers)
    Map.put(request, :headers, headers)
  end

  def put_params(%__MODULE__{} = request, params) do
    params = Map.merge(request.params, params)
    Map.put(request, :params, params)
  end
end
