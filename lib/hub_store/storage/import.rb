require "hub_link"
require "hub_store/storage/database"

module HubStore
  module Storage
    class Import
      def initialize(repo:, since: nil)
        @repo = repo
        @since = since
      end

      def run(&block)
        HubLink::Importer.run(repo: repo, since: since, resources: RESOURCES, &block)
      end

      private

        attr_reader :repo

        def since
          @since.presence || last_pull_request_update
        end

        def last_pull_request_update
          PullRequest.for(repo).latest_update
        end
    end
  end
end
