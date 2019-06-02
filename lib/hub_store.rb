require "dotenv/load"
require "hub_store/version"
require "hub_store/cli"
require "hub_store/storage/pull_request"
require "hub_store/storage/review"
require "hub_store/storage/review_request"

module HubStore
  RESOURCES = {
    review_requests: Storage::ReviewRequest,
    reviews: Storage::Review,
    pull_requests: Storage::PullRequest
  }.freeze
end
