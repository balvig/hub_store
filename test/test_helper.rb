$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "hub_store"
require "minitest/autorun"
require "vcr"
require "webmock/minitest"

# Intercept GitHub requests
VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

# Create dummy DB in memory
HubStore::Storage::Database.new(adapter: "sqlite3", database: ":memory:").setup
