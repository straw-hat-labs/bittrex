defmodule Bittrex do
  @moduledoc """
  Contains a functions for credentials and common utility functions.
  """

  @doc false
  def format_datetime(nil), do: nil

  def format_datetime(datetime_string) do
    datetime_string
    |> Integer.parse()
    |> elem(0)
    |> DateTime.from_unix!(:millisecond)
  end

  @doc false
  def camelcase_keys(struct) do
    StrawHat.Utils.Map.deep_map(struct, &camelize_key/1, &StrawHat.identity/1)
  end

  def snake_keys(struct) do
    StrawHat.Utils.Map.deep_map(struct, &snake_key/1, &StrawHat.identity/1)
  end

  defp snake_key(key) do
    key
    |> to_string()
    |> Recase.to_snake()
  end

  defp camelize_key(key) do
    key
    |> to_string()
    |> Recase.to_camel()
  end
end
