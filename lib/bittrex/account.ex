defmodule Bittrex.Account do
  @moduledoc """
  Implements /account endpoints.
  """

  alias StrawHat.Response
  alias Bittrex.{Client, HttpRequest}

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
    |> HttpRequest.new()
    |> HttpRequest.put_method(:get)
    |> HttpRequest.put_path("/account")
    |> Client.send()
    |> StrawHat.Response.and_then(fn data ->
      data
      |> new()
      |> Response.ok()
    end)
  end

  @doc false
  def new(data) do
    %__MODULE__{
      email: data["email"],
      id: data["id"],
      is_international: data["isInternational"]
    }
  end
end
