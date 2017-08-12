defmodule Bittrex do
  @credentials Application.get_env(:bittrex, :credentials)

  def api_key do
    @credentials[:api_key]
  end

  def api_secret do
    @credentials[:api_secret]
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
    {:ok, date} = NaiveDateTime.from_iso8601(datetime_string)
    date
  end
end
