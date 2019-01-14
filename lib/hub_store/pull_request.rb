require "active_record"

module HubStore
  class PullRequest < ActiveRecord::Base
    def self.resume_date
      group(:repo).order(updated_at: :asc).pluck(:updated_at).min
    end
  end
end
