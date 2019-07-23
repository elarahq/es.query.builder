# frozen_string_literal: true

module Aggregations
  module Helpers
    # A helper module for aggregations, defines sub aggregation attributes.
    module AbstractAggregationHelper
      # helper method to add abstract aggregation attributes to aggregation.
      def abstract_agg_builder
        builder = {}
        builder[:aggs] = build_sub_aggs_struct if @sub_aggregations.present?
        builder
      end

      # @param [AggregationQueryBuilderHelper] sub_agg : AggregationBuilders factory
      # @return [AbstractAggregationHelper] : aggregation object
      def sub_aggregation(sub_agg)
        @sub_aggregations = [] if @sub_aggregations.nil?
        @sub_aggregations = @sub_aggregations.append(sub_agg)
        self
      end

      # @return [AbstractAggregationHelper] : aggregation object
      def sub_aggregation_expr
        @sub_aggregations
      end

      private

      def build_sub_aggs_struct
        @sub_aggregations.each_with_object({}) do |ag, qr|
          qr.merge!(ag.attributes.query)
          qr
        end
      end
    end
  end
end
