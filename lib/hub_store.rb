require "dotenv/load"
require "hub_store/version"
require "hub_store/importer"
require "hub_store/exporter"

module HubStore
  class Error < StandardError; end
	# Set up database
	ActiveRecord::Base.establish_connection(
		adapter: "sqlite3",
		database: "db/hub_store"
	)

	# Set up database tables and columns
	ActiveRecord::Schema.define do
    unless ActiveRecord::Base.connection.table_exists?("pull_requests")
      create_table "pull_requests", force: :cascade do |t|
        t.string "submitter"
        t.string "number"
        t.string "labels"
        t.string "repo"
        t.integer "approval_time"
        t.integer "time_to_first_review"
        t.integer "merge_time"
        t.integer "additions"
        t.integer "review_count"
        t.boolean "straight_approval"
        t.datetime "closed_at"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
      end
    end

    unless ActiveRecord::Base.connection.table_exists?("reviews")
      create_table "reviews", force: :cascade do |t|
        t.bigint "pull_request_id"
        t.datetime "submitted_at", null: false
        t.string "reviewer"
        t.boolean "approval"
      end
    end

    unless ActiveRecord::Base.connection.table_exists?("review_requests")
      create_table "review_requests", force: :cascade do |t|
        t.string "requester"
        t.string "reviewer"
        t.datetime "created_at", null: false
      end
    end
	end
end
