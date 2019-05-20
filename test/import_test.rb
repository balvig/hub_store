require "test_helper"

module HubStore
  class ImporterTest < Minitest::Test
    def test_run
      VCR.use_cassette("import") do
        Storage::Import.new(repo: "balvig/spyke").run do |on|
          on.init do |query|
            puts query
          end
        end
      end

      assert_equal 4, PullRequest.count
      assert_equal 2, Review.count
      assert_equal 0, ReviewRequest.count
    end
  end
end
