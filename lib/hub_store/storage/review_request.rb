require "active_record"

module HubStore::Storage
  class ReviewRequest < ActiveRecord::Base
    self.primary_key = :digest
  end
end
