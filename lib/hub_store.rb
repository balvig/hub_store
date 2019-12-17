require "dotenv/load"
require "hub_store/version"
require "hub_store/cli"
require "hub_store/storage/pull_request"
require "hub_store/storage/review"

module HubStore
  RESOURCES = {
    reviews: Storage::Review,
    pull_requests: Storage::PullRequest
  }.freeze
end
