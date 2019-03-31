defmodule Bittrex.Address do
  @moduledoc """
  A Bittrex Address.
  """

  alias StrawHat.Response

  @typedoc """
  - `status`: the status of this deposit address.
  - `currency_symbol`: the unique ID of the currency this deposit address is
  for.
  - `crypto_address`: the cryptographic deposit address.
  """
  @type t :: %__MODULE__{
          status: String.t(),
          currency_symbol: String.t(),
          crypto_address: String.t()
        }

  defstruct [:status, :currency_symbol, :crypto_address]

  @doc false
  def new(data) do
    %__MODULE__{
      status: data["status"],
      currency_symbol: data["currencySymbol"],
      crypto_address: data["cryptoAddress"]
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
