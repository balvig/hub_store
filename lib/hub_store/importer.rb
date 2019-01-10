require "hub_link"
require "hub_store/insert"
require "hub_store/pull_request"
require "hub_store/review"

module HubStore
  class Importer
    def initialize(repos:, start_date: 2.years.ago)
      @repos = repos
      @start_date = start_date
    end

    def run
      stream.in_batches do |batch|
        import_prs(batch.pull_requests)
        import_reviews(batch.reviews)
      end
    end

    private

      attr_reader :repos, :start_date

      def import_prs(rows)
        rows.each do |row|
          Insert.new(row: row, target: PullRequest).run
        end

        puts "Imported #{PullRequest.count} PRs so far"
      end

      def import_reviews(rows)
        rows.each do |row|
          Insert.new(row: row, target: Review).run
        end

        puts "Imported #{Review.count} reviews so far"
      end

      def stream
        @_stream ||= HubLink::Stream.new(repos, start_date: start_date)
      end
  end
end
