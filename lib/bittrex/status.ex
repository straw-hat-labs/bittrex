defmodule Bittrex.Status do
  @moduledoc """
  Implements /status endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, HttpRequest, ServiceStatus}

  @doc """
  Check service status.
  """
  @spec get_status(%Client{}) :: Response.t(%ServiceStatus{}, Client.error())
  def get_status(client) do
    client
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/status")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> ServiceStatus.new()
      |> Response.ok()
    end)
  end
end
