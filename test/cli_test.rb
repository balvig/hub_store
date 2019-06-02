require "test_helper"

module HubStore
  class CliTest < Minitest::Test
    def test_run
      Cli.run(["balvig/spyke"]).run
    end
  end
end
