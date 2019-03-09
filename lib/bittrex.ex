defmodule Bittrex do
  @moduledoc """
  Contains a functions for credentials and commo utility functions.
  """

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
