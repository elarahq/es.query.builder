# A helper module for aggregations, defines ranges, keyed attributes.
module Aggregations
  module Helpers
    module AbstractRangeHelper

      # helper method to add abstract range attributes to aggregation.
      def abstract_range_builder
        builder = {}
        builder[:ranges] = @ranges if @ranges.present?
        builder[:keyed] = @keyed if @keyed.present?
        builder
      end

      # @param [Misc::Range] range
      # @return [AbstractRangeHelper], can be chained for adding multiple ranges.
      def add_range range
        @ranges ||= []
        @ranges << range.settings
        self
      end

      # @return [Array]
      def ranges_expr
        @ranges
      end

      # @param [Boolean] keyed
      def keyed keyed
        @keyed = keyed
        self
      end

      # @return [Boolean]
      def keyed_expr
        @keyed
      end

    end
  end
end