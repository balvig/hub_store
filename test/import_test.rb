require "test_helper"

module HubStore
  class ImportTest < Minitest::Test
    def test_run
      Storage::Import.new(repo: "balvig/spyke").run

      assert_equal 4, PullRequest.count
      assert_equal 2, Review.count
      assert_equal 0, ReviewRequest.count
    end
  end
end
