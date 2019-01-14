require "test_helper"

module HubStore
  class PullRequestTest < Minitest::Test
    def test_resume_date
      expected_resume_date = 3.days.ago
      PullRequest.create!(repo: "balvig/hub_link", updated_at: 2.days.ago)
      PullRequest.create!(repo: "balvig/hub_link", updated_at: 4.days.ago)
      PullRequest.create!(repo: "balvig/hub_store", updated_at: expected_resume_date)

      assert_equal expected_resume_date, PullRequest.resume_date
    end
  end
end
