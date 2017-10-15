# Bittrex

## Installation

Add `bittrex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:bittrex, "~> 0.5"}]
end
```

## Usage

Add credentials from Bittrex. To manage your API keys please goto
`Settings -> Manage API Keys` on Bittrex.

```elixir
# config/config.exs
config :bittrex,
  credentials: [
    api_key: "",
    api_secret: ""
  ]
```

From now on, just check the available modules and functions so you can find
the data that you need. The module and function are self descriptive but if you
have any feedback open a PR and we add some documentation.
