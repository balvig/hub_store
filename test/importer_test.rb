require "test_helper"

module HubStore
  class ImporterTest < Minitest::Test
    def test_run
      resources = {
        pull_requests: PullRequest,
        reviews: Review,
        review_requests: ReviewRequest
      }

      VCR.use_cassette("import") do
        Importer.run(repo: "balvig/spyke", start_date: 1.year.ago, resources: resources, batch_size: 90) do |on|
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
