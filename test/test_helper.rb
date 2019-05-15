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
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define do
  create_table "pull_requests", force: :cascade do |t|
    t.string "repo"
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
  end

  create_table "review_requests", force: :cascade, id: false do |t|
    t.string "digest", limit: 40, primary: true
  end
end
