module Aggregations
  module Buckets
    # Elasticsearch Histogram Aggregation
    class HistogramAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      ATTRIBUTES = [:order, :interval, :min_doc_count]

      # @param [String] name : Aggregation name
      def initialize name:
        @name = name.intern
        @type = :histogram
        @query = {
          @name => {
            @type => {}
          }
        }
      end

      # @param [Misc::BucketOrder] bucket_order
      # @return [HistogramAggregationBuilder], can be chained for ordering on multiple fields.
      def add_order bucket_order
        @order ||= []
        @order << bucket_order.settings
        self
      end

      # @return [Array]
      def order_expr
        @order
      end

      # @param [String] interval
      # @return [HistogramAggregationBuilder]
      def interval interval
        @interval = interval
        self
      end

      # @return [String]
      def interval_expr
        @interval
      end

      # @param [Integer] doc_count
      # @return [HistogramAggregationBuilder]
      def min_doc_count doc_count
        @min_doc_count = doc_count
        self
      end

      # @return [Integer]
      def min_doc_count_expr
        @min_doc_count
      end

    end
  end
end