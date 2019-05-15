require "hub_store/importer"
require "hub_store/exporter"
require "hub_store/pull_request"
require "hub_store/repo"
require "hub_store/review"
require "hub_store/review_request"
require "hub_store/ui"

module HubStore
  class Cli
    RESOURCES = {
      pull_requests: PullRequest,
      reviews: Review,
      review_requests: ReviewRequest
    }.freeze

    def self.run(*args)
      new(*args).run
    end

    def initialize(argv)
      @argv = argv
    end

    def run
      import_data
      export_csv
    end

    private

      attr_reader :argv

      def import_data
        repos.each do |repo|

          Importer.run(repo: repo, start_date: repo.latest_local_update, resources: RESOURCES) do |on|
            on.init do |query|
              ui.log "\n-- #{query} --"
            end

            on.start do |resource|
              ui.start("Importing #{resource}")
            end

            on.finish do |count|
              ui.stop("Total: #{count}")
            end
          end
        end
      end

      def export_csv
        RESOURCES.values.each do |resource|
          ui.start("Exporting #{resource}")
          Exporter.new(resource: resource).run
          ui.stop("Done.")
        end
      end

      def ui
        @_ui ||= Ui.new
      end

      def repos
        repo_names.split(",").map do |name|
          Repo.new(name)
        end
      end

      def repo_names
        argv[0].presence || stop
      end

      def stop
        puts "\nUsage: OCTOKIT_ACCESS_TOKEN=<token> #{$0} <github_org/repo_name>"
        exit
      end
  end
end
