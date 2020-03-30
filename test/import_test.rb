require "test_helper"

module HubStore
  class ImportTest < Minitest::Test
    def test_importing_prs
      import

      assert_equal 41, Storage::PullRequest.count
    end

    def test_importing_issues
      import

      assert_equal 2, Storage::Issue.count
    end

    def test_importing_reviews
      import

      assert_equal 2, Storage::Review.count
    end

    private

      def import
        Storage::Import.new(repo: "balvig/spyke").run
      end
  end
end
