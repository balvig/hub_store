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

      def start_date
        PullRequest.order(updated_at: :desc).limit(1).pluck(:updated_at).first
      end

      def import_data
        Importer.new(repos: repo_names, start_date: start_date).run
      end

      def export_csv
        [PullRequest, Review].each do |resource|
          Exporter.new(resource: resource).run
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
