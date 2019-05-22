require "hub_link/importer"
require "hub_store/storage/pull_request"
require "hub_store/storage/review"
require "hub_store/storage/review_request"

module HubStore::Storage
  class Import
    def initialize(repo:, resources:, start_date: nil)
      @repo = repo
      @resources = resources
      @start_date = start_date
    end

    def run(&block)
      HubLink::Importer.run(repo: repo, start_date: start_date, resources: resources, &block)
    end

    private

      attr_reader :repo, :resources

      def start_date
        @start_date.presence || PullRequest.for(repo).latest_update
      end
  end
end
