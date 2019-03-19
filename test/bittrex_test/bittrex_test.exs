defmodule BittrexTest do
  use ExUnit.Case, async: true

  test "camel casing keys of an struct" do
    input = %{
      hello_world: "123",
      nested_struct: %{
        hello_world: "123"
      }
    }

    output = %{
      helloWorld: "123",
      nestedStruct: %{
        helloWorld: "123"
      }
    }

    assert output == Bittrex.camelcase_keys(input)
  end
end
