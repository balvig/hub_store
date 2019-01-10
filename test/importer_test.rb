require "test_helper"

module HubStore
  class ImporterTest < Minitest::Test
    def test_importing
      Importer.new(repos: "balvig/hub_link").run
    end
  end
end
