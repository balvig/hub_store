require "dotenv/load"
require "hub_store/version"
require "hub_store/importer"
require "hub_store/exporter"

module HubStore
  class Error < StandardError; end

	# Set up a database that resides in RAM
	ActiveRecord::Base.establish_connection(
		adapter: "sqlite3",
		database: "db/hub_store"
	)

	# Set up database tables and columns
	ActiveRecord::Schema.define do
    unless ActiveRecord::Base.connection.table_exists?("pull_requests")
      create_table "pull_requests", force: :cascade do |t|
        t.string "submitter"
        t.string "labels"
        t.datetime "closed_at"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
      end
    end

    unless ActiveRecord::Base.connection.table_exists?("reviews")
      create_table "reviews", force: :cascade do |t|
        t.bigint "pull_request_id"
        t.datetime "submitted_at"
        t.string "reviewer"
        t.boolean "approval"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
      end
    end
	end
end
