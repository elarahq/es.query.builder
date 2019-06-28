# A helper module for aggregations, defines sub aggregation attributes.
module Aggregations
  module Helpers
    module AbstractAggregationHelper

      # helper method to add abstract aggregation attributes to aggregation.
      def abstract_agg_builder
        builder = {}
        builder[:aggs] = @sub_aggregation if @sub_aggregation.present?
        builder
      end

      # @param [AggregationQueryBuilderHelper] sub_agg : use AggregationBuilders factory
      # @return [AbstractAggregationHelper] : aggregation object
      def sub_aggregation sub_agg
        @sub_aggregation = sub_agg.attributes.query
        self
      end

      # @return [AbstractAggregationHelper] : aggregation object
      def sub_aggregation_expr
        @sub_aggregation
      end

    end
  end
end