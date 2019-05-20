require "hub_store/exporter"

require "hub_store/storage/database"
require "hub_store/storage/import"

require "hub_store/ui"

module HubStore
  class Cli
    RESOURCES = {
      pull_requests: Storage::PullRequest,
      reviews: Storage::Review,
      review_requests: Storage::ReviewRequest
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
        ui.start("Preparing dB")
        Storage::Database.new(adapter: "sqlite3", database: "hub_store_db").setup
        ui.stop("Done.")
      end

      def import_data
        repos.each do |repo|
          Storage::Import.new(repo: repo, resources: RESOURCES).run do |on|
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

      def stop
        puts "\nUsage: OCTOKIT_ACCESS_TOKEN=<token> #{$0} <github_org/repo_name>"
        exit
      end
  end
end
