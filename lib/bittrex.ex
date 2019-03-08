defmodule Bittrex do
  @moduledoc """
  Contains a functions for credentials and commo utility functions.
  """

  def api_signature(url, content_hash) do
    # var uri = 'https://api.bittrex.com/v3/balances';
    # var preSign = [timestamp, uri, contentHash].join('');
    # var signature = CryptoJS.HmacSHA512(preSign, apiSecret).toString(CryptoJS.enc.ASCII);
  end

  @doc """
  Get the credentials of Bittrex.
  """
  @spec credentials() :: keyword
  def credentials do
    Application.fetch_env!(:bittrex, :credentials)
  end

  @doc """
  Get the API Key from the credentials.
  """
  @spec api_key() :: String.t()
  def api_key do
    credentials() |> Keyword.get(:api_key)
  end

  @doc """
  Get the API Secret from the credentials
  """
  @spec api_secret() :: String.t()
  def api_secret do
    credentials() |> Keyword.get(:api_secret)
  end

  @doc """
  Returns the encrypted API Sign header value.
  """
  @spec get_api_sign(String.t()) :: String.t()
  def get_api_sign(url) do
    secret = api_secret()

    :sha512
    |> :crypto.hmac(secret, url)
    |> Base.encode16()
    |> String.downcase()
  end

  @doc """
  Nonce used for the authorization.
  """
  @spec nonce() :: integer
  def nonce do
    :os.system_time(:milli_seconds)
  end

  @doc """
  Format Bittrex date time to Elixir `t:NaiveDateTime.t/0`.
  """
  @spec format_datetime(nil) :: nil
  def format_datetime(nil), do: nil
  @spec format_datetime(String.t()) :: NaiveDateTime.t() | nil
  def format_datetime(datetime_string) do
    case NaiveDateTime.from_iso8601(datetime_string) do
      {:ok, date} -> date
      _ -> nil
    end
  end
end
