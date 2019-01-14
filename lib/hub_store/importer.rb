require "hub_link"
require "hub_store/insert"
require "hub_store/pull_request"
require "hub_store/review"
require "hub_store/review_request"

module HubStore
  class Importer
    def initialize(repo:, start_date: nil, ui: Ui.new)
      @repo = repo
      @start_date = (start_date || 2.years.ago).to_date
      @ui = ui
    end

    def run
      stream.in_batches do |batch|
        ui.log "\n-- #{batch.query} --"
        import_prs(batch)
        import_reviews(batch)
        import_review_requests(batch)
      end
    end

    private

      attr_reader :repo, :start_date, :ui

      def import_prs(batch)
        ui.start("Importing PRs")

        batch.pull_requests.each do |row|
          Insert.new(row: row, target: PullRequest).run
        end

        ui.stop("Total: #{PullRequest.count}")
      end

      def import_reviews(batch)
        ui.start("Importing reviews")

        batch.reviews.each do |row|
          Insert.new(row: row, target: Review).run
        end

        ui.stop("Total: #{Review.count}")
      end

      def import_review_requests(batch)
        ui.start("Importing review requests")

        batch.review_requests.each do |row|
          Insert.new(row: row, target: ReviewRequest).run
        end

        ui.stop("Total: #{ReviewRequest.count}")
      end

      def stream
        @_stream ||= HubLink::Stream.new(repo, start_date: start_date)
      end
  end
end
