require "test_helper"

module HubStore
  class ExporterTest < Minitest::Test
    def test_exporting
      [PullRequest, Review, ReviewRequest].each do |resource|
        Exporter.new(resource: resource).run
      end
    end
  end
end
