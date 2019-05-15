require "csv"

module HubStore
  class Exporter
    def initialize(resource:)
      @resource = resource
    end

    def run
      export_csv
    end

    private

      attr_reader :resource

      def export_csv
        CSV.open(csv_file_name, "w", write_headers: true, headers: columns) do |csv|
          resource.find_each do |record|
            csv << record.attributes.values
          end
        end
      end

      def csv_file_name
        resource.to_s.demodulize.pluralize.underscore + ".csv"
      end

      def columns
        @_columns ||= resource.columns.map(&:name)
      end
  end
end
