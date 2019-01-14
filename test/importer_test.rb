require "test_helper"

module HubStore
  class ImporterTest < Minitest::Test
    def test_importing
      VCR.use_cassette("import") do
        Importer.new(repo: "balvig/hub_link", start_date: 2.weeks.ago).run

        assert_equal 1, PullRequest.count
      end
    end
  end
end
