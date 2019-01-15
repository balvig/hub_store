require "active_record"

module HubStore
  class PullRequest < ActiveRecord::Base
    scope :recently_updated_first, -> { order(updated_at: :desc) }
    validates :repo, presence: true

    def self.for(repo)
      where(repo: repo)
    end
  end
end
