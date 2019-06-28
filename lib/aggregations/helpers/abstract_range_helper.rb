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

      # @param [String] from
      # @param [String] to
      # @param [String] key
      # @return [calling class object]
      def add_range from: nil, to: nil, key: ''
        @ranges ||= []
        range = {}
        range[:key] = key if key.present?
        range[:from] = from if from.present?
        range[:to] = to if to.present?
        @ranges << range if range.present?
        self
      end

      def get_ranges
        @ranges
      end

      def keyed keyed
        @keyed = keyed
        self
      end

      def get_keyed
        @keyed
      end

    end
  end
end