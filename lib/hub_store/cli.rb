require "hub_store/exporter"

require "hub_store/storage/database"
require "hub_store/storage/import"

require "hub_store/ui"

module HubStore
  class Cli
    RESOURCES = {
      review_requests: Storage::ReviewRequest,
      reviews: Storage::Review,
      pull_requests: Storage::PullRequest
    }.freeze

    def self.run(*args)
      new(*args).run
    end

    def initialize(argv)
      @argv = argv
    end

    def run
      setup_database
      import_data
      export_csv
    end

    private

      attr_reader :argv

      def setup_database
        ui.start("Preparing database")
        Storage::Database.new.setup
        ui.stop("Done.")
      end

      def import_data
        repos.each do |repo|
          Storage::Import.new(repo: repo, resources: RESOURCES, start_date: start_date).run do |on|
            on.init do |options|
              ui.log "\n-- #{options} --"
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
        RESOURCES.each do |name, resource|
          ui.start("Exporting #{name}")
          Exporter.new(resource: resource).run
          ui.stop("Done.")
        end
      end

      def ui
        @_ui ||= Ui.new
      end

      def repos
        repo_names.split(",")
      end

      def repo_names
        argv[0].presence || stop
      end

      def start_date
        ENV["START_DATE"]
      end

      def stop
        puts "\nUsage: OCTOKIT_ACCESS_TOKEN=<token> #{$0} <github_org/repo_name>"
        exit
      end
  end
end
