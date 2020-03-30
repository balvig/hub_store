require "active_record"

module HubStore::Storage
  class Issue < ActiveRecord::Base
    scope :recently_updated_first, -> { order(updated_at: :desc) }
    validates :repo, presence: true

    def self.for(repo)
      where(repo: repo.to_s)
    end

    def self.latest_update
      recently_updated_first.first&.updated_at
    end
  end
end
