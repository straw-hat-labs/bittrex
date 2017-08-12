defmodule Bittrex.Interactor do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      alias Bittrex.HttpRequest
      alias Bittrex.Client
    end
  end
end
