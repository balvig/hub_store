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
      import_data
      export_csv
    end

    private

      attr_reader :argv

      def import_data
        repos.each do |repo|
          Importer.new(repo: repo).run
        end
      end

      def export_csv
        [PullRequest, Review, ReviewRequest].each do |resource|
          Exporter.new(resource: resource).run
        end
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
