require "active_record"

module HubStore::Storage
  class Database
    def initialize(options = { adapter: "sqlite3", database: "hub_store_db" })
      @options = options
    end

    def setup
      connect
      create_tables
    end

    private

      attr_reader :options

      def connect
        ActiveRecord::Base.establish_connection(options)
      end

      def create_tables
        ActiveRecord::Schema.define do
          unless ActiveRecord::Base.connection.table_exists?("pull_requests")
            create_table "pull_requests", force: :cascade do |t|
              t.string "title"
              t.string "submitter"
              t.string "number"
              t.string "labels"
              t.string "repo"
              t.string "state"
              t.string "html_url"
              t.integer "additions"
              t.integer "comments_count"
              t.integer "review_comments_count"
              t.datetime "closed_at"
              t.datetime "merged_at"
              t.datetime "created_at", null: false
              t.datetime "updated_at", null: false
            end
          end

          unless ActiveRecord::Base.connection.table_exists?("reviews")
            create_table "reviews", force: :cascade do |t|
              t.bigint "pull_request_id"
              t.datetime "submitted_at"
              t.string "reviewer"
              t.string "state"
              t.string "html_url"
              t.text "body"
            end
          end

          unless ActiveRecord::Base.connection.table_exists?("review_requests")
            create_table "review_requests", force: :cascade, id: false do |t|
              t.string "digest", limit: 40, primary: true
              t.bigint "pull_request_id"
              t.string "requester"
              t.string "reviewer"
              t.datetime "created_at", null: false
            end
          end
        end
      end
  end
end
