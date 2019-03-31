defmodule Bittrex.Status do
  @moduledoc """
  Implements /status endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, Client.Request, ServiceStatus}

  @doc """
  Check service status.
  """
  @spec get_status(%Client{}) :: Response.t(%ServiceStatus{}, Client.error())
  def get_status(client) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/status")
    |> Client.send()
    |> StrawHat.Response.and_then(&ServiceStatus.transform_response/1)
  end
end
