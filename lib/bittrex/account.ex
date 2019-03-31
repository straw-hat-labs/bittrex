defmodule Bittrex.Account do
  @moduledoc """
  Implements /account endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, Client.Request}

  @typedoc """
  - `id`: the account ID associated with this API key / user.
  - `email`: the email address associated with this API key / user.
  - `is_international`: true if this account has access to international
  markets, false otherwise.
  """
  @type t :: %__MODULE__{
          email: String.t(),
          id: String.t(),
          is_international: boolean()
        }

  defstruct [:email, :id, :is_international]

  @doc """
  Retrieve account information.
  """
  @spec get_account(%Client{}) :: Response.t(%__MODULE__{}, Client.error())
  def get_account(client) do
    client
    |> Request.new()
    |> Request.put_method(:get)
    |> Request.put_path("/account")
    |> Client.send()
    |> StrawHat.Response.and_then(&transform_response/1)
  end

  @doc false
  def new(data) do
    %__MODULE__{
      email: data["email"],
      id: data["id"],
      is_international: data["isInternational"]
    }
  end

  defp transform_response(data) do
    data
    |> new()
    |> Response.ok()
  end
end
