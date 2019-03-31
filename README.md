# Bittrex

[![Hex.pm](https://img.shields.io/hexpm/v/bittrex.svg)](https://hex.pm/packages/bittrex)
[![CI Status](https://travis-ci.org/straw-hat-team/bittrex.svg?branch=master)](https://travis-ci.org/straw-hat-team/bittrex)
[![Code Coverage](https://codecov.io/gh/straw-hat-team/bittrex/branch/master/graph/badge.svg)](https://codecov.io/gh/straw-hat-team/bittrex)

[Bittrex API](https://bittrex.github.io/api/v3) integration.

## Usage

First, create the credentials from Bittrex. To manage your API keys please goto
`Settings -> Manage API Keys` on Bittrex.

You need to create an `Bittrex.Client` using `Bittrex.Client.new/1`

    client = Bittrex.Client.new(%{
      api_key: "my api key",
      api_secret: "my api secret"
    })

Now you can use the available functions for communicate with Bittrex API.

Example:

    client = Bittrex.Client.new(%{
      api_key: "my api key",
      api_secret: "my api secret"
    })

    {:ok, markets} = Bittrex.Markets.get_markets(client)

Check the current modules, the module names are trying to follow the same
structure from the [official documentation of Bittrex API](https://bittrex.github.io/api/v3).
