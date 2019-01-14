require "hub_link"
require "hub_store/insert"
require "hub_store/pull_request"
require "hub_store/review"
require "hub_store/review_request"

module HubStore
  class Importer
    def initialize(repo:, start_date: nil)
      @repo = repo
      @start_date = start_date || 2.years.ago
    end

    def run
      stream.in_batches do |batch|
        import_prs(batch)
        import_reviews(batch)
        import_review_requests(batch)
      end
    end

    private

      attr_reader :repo, :start_date

      def import_prs(batch)
        batch.pull_requests.each do |row|
          Insert.new(row: row, target: PullRequest).run
        end

        log "Imported #{PullRequest.count} PRs so far"
      end

      def import_reviews(batch)
        batch.reviews.each do |row|
          Insert.new(row: row, target: Review).run
        end

        log "Imported #{Review.count} reviews so far"
      end

      def import_review_requests(batch)
        batch.review_requests.each do |row|
          Insert.new(row: row, target: ReviewRequest).run
        end

        log "Imported #{ReviewRequest.count} review requests so far"
      end

      def log(msg)
        puts msg
      end

      def stream
        @_stream ||= HubLink::Stream.new(repo, start_date: start_date)
      end
  end
end
