require "active_record"

module HubStore
  class ReviewRequest < ActiveRecord::Base
    self.primary_key = :digest
  end
end
