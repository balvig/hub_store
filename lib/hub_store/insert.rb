module HubStore
  class Insert
    def initialize(row:, target:)
      @row = row
      @target = target
    end

    def run
      record.update! importable_attributes
    end

    private

      def record
        target.find_or_initialize_by(id: id)
      end

      def id
        row[:id]
      end

      def importable_attributes
        row.slice(*target_columns)
      end

      def target_columns
        target.columns.map(&:name)
      end

      attr_reader :row, :target
  end
end
