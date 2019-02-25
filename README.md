# Bittrex

[![Hex.pm](https://img.shields.io/hexpm/v/bittrex.svg)](https://hex.pm/packages/bittrex)
[![CI Status](https://travis-ci.org/straw-hat-team/bittrex.svg?branch=master)](https://travis-ci.org/straw-hat-team/bittrex)
[![Code Coverage](https://codecov.io/gh/straw-hat-team/bittrex/branch/master/graph/badge.svg)](https://codecov.io/gh/straw-hat-team/bittrex)

[Bittrex API](https://bittrex.github.io/api/v3) integration.

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
