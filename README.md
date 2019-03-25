# Bittrex

[![Hex.pm](https://img.shields.io/hexpm/v/bittrex.svg)](https://hex.pm/packages/bittrex)
[![CI Status](https://travis-ci.org/straw-hat-team/bittrex.svg?branch=master)](https://travis-ci.org/straw-hat-team/bittrex)
[![Code Coverage](https://codecov.io/gh/straw-hat-team/bittrex/branch/master/graph/badge.svg)](https://codecov.io/gh/straw-hat-team/bittrex)

[Bittrex API](https://bittrex.github.io/api/v3) integration.

## Usage

First, create the credentials from Bittrex. To manage your API keys please goto
`Settings -> Manage API Keys` on Bittrex.

You need to create an `Bittrex.HttpClient` using `Bittrex.HttpClient.new/1`

```elixir
client = Bittrex.HttpClient.new("my api key", "my api secret")
```

Now you can use the available functions for communicate with Bittrex API.

Example:

```elixir
client = Bittrex.HttpClient.new("my api key", "my api secret")

{:ok, markets} = Bittrex.Markets.get_markets(client)
```
