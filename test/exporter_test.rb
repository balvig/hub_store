require "test_helper"

module HubStore
  class ExporterTest < Minitest::Test
    def test_exporting
      [Storage::PullRequest, Storage::Review].each do |resource|
        Exporter.new(resource: resource).run
      end
    end
  end
end
