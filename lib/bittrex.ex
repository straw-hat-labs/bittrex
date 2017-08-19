defmodule Bittrex do
  def credentials do
    Application.get_env(:bittrex, :credentials)
  end

  def api_key do
    credentials() |> Keyword.get(:api_key)
  end

  def api_secret do
    credentials() |> Keyword.get(:api_secret)
  end

  def get_api_sign(url) do
    secret = api_secret()

    :sha512
    |> :crypto.hmac(secret, url)
    |> Base.encode16()
    |> String.downcase()
  end

  def nonce do
    :os.system_time(:milli_seconds)
  end

  def format_datetime(datetime_string) do
    case NaiveDateTime.from_iso8601(datetime_string) do
      {:ok, date} -> date
      _ -> nil
    end
  end
end
