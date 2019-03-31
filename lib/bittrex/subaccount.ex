defmodule Bittrex.Subaccount do
  @moduledoc """
  A Bittrex Subaccount.
  """

  alias StrawHat.Response

  @typedoc """
  - `id`: unique ID of this subaccount.
  - `created_at`: when the account was created.
  """
  @type t :: %__MODULE__{
          id: String.t(),
          created_at: NaiveDateTime.t()
        }

  defstruct [:id, :created_at]

  @doc false
  def new(data) do
    %__MODULE__{
      id: data["id"],
      created_at: Bittrex.format_datetime(data["createdAt"])
    }
  end

  @doc false
  def transform_response(data) when is_list(data) do
    data
    |> Enum.map(&new/1)
    |> Response.ok()
  end

  @doc false
  def transform_response(data) do
    data
    |> new()
    |> Response.ok()
  end
end
