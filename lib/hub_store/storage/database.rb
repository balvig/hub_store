require "active_record"

module HubStore::Storage
  class Database
    def initialize(options = {})
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
              t.string "state"
              t.boolean "approval"
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
