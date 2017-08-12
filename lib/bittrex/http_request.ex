defmodule Bittrex.HttpRequest do
  @base_url Application.get_env(:bittrex, :base_url, "https://bittrex.com/api/")
  @version Application.get_env(:bittrex, :version, "v1.1")

  defstruct [:method, :url, :headers, :params]

  def new(method, path, params \\ [], headers \\ []) do
    url = process_url(path)

    %__MODULE__{
      method: method,
      url: url,
      params: params,
      headers: headers}
  end

  def process_url(path) do
    @base_url <> @version <> path
  end

  def full_url(%__MODULE__{} = request) do
    request.url <> "?" <> URI.encode_query(request.params)
  end

  def put_header(%__MODULE__{} = request, headers) do
    headers = Keyword.merge(request.headers, headers)
    Map.put(request, :headers, headers)
  end

  def put_params(%__MODULE__{} = request, params) do
    params = Keyword.merge(request.params, params)
    Map.put(request, :params, params)
  end
end
