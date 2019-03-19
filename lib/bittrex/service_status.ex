defmodule Bittrex.ServiceStatus do
  @moduledoc """
  A Bittrex Service Status.
  """

  @typedoc """
  - `status`: overall service status.
  - `server_time`: server time in epoch millisecond format.
  """
  @type t :: %__MODULE__{
          status: String.t(),
          server_time: integer()
        }

  defstruct [:status, :server_time]

  @doc false
  def new(data) do
    %__MODULE__{
      status: data["status"],
      server_time: data["serverTime"]
    }
  end
end
