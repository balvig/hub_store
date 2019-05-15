require "hub_store/pull_request"

module HubStore
  class Repo
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def latest_local_update
      imported_pull_requests.recently_updated_first.first&.updated_at
    end

    def to_s
      name
    end

    private

      def imported_pull_requests
        PullRequest.for(self)
      end
  end
end
