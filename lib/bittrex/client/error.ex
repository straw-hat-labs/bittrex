defmodule Bittrex.Client.Error do
  @moduledoc """
  An Client error.
  """

  @typedoc """
  - `status_code`: the HTTP status code.
  - `reason`: the http body.
  """
  @type t :: %__MODULE__{
          status_code: integer(),
          reason: any()
        }

  @enforce_keys [:status_code, :reason]
  defstruct [:status_code, :reason]

  def new(status_code, reason) do
    %__MODULE__{
      status_code: status_code,
      reason: reason
    }
  end
end
