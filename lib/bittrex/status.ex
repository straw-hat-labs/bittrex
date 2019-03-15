defmodule Bittrex.Status do
  @moduledoc """
  Implements /status endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{HttpClient, HttpRequest, ServiceStatus}

  @doc """
  Check service status.
  """
  @spec get_status(%HttpClient{}) :: Response.t(%ServiceStatus{}, any())
  def get_status(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/status")
    |> HttpClient.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> ServiceStatus.new()
      |> Response.ok()
    end)
  end
end
