use Mix.Config

config :exvcr, [
  vcr_cassette_library_dir: "test/support/fixtures/vcr_cassettes",
  custom_cassette_library_dir: "test/support/fixtures/custom_vcr_cassettes",
  filter_sensitive_data: [],
  filter_url_params: false,
  filter_request_headers: [],
  response_headers_blacklist: []
]
