require "test_helper"

module HubStore
  class ImportTest < Minitest::Test
    def test_run
      Storage::Import.new(repo: "balvig/spyke").run

      assert_equal 4, Storage::PullRequest.count
      assert_equal 2, Storage::Review.count
    end
  end
end
