require "hub_store/exporter"
require "hub_store/storage/import"
require "hub_store/ui"

module HubStore
  class Cli
    def self.run(*args)
      new(*args).run
    end

    def initialize(argv)
      @argv = argv
    end

    def run
      link_logger_to_ui
      import_data
      export_csv
    end

    private

      attr_reader :argv

      def link_logger_to_ui
        HubLink.config.logger = ui
      end

      def import_data
        repos.each do |repo|
          Storage::Import.new(repo: repo, since: since).run
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

      def since
        ENV["SINCE"]
      end

      def stop
        puts "\nUsage: OCTOKIT_ACCESS_TOKEN=<token> #{$0} <github_org/repo_name>"
        exit
      end
  end
end
