$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "hub_store"
require "minitest/autorun"

# Create dummy DB in memory
HubStore::Storage::Database.new(adapter: "sqlite3", database: ":memory:").setup
