module Aggregations
  module Buckets
    # Elasticsearch Date Histogram Aggregation
    class DateHistogramAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      ATTRIBUTES = [:order, :calendar_interval, :min_doc_count]

      # @param [String] name : Aggregation name
      def initialize name:
        @name = name.intern
        @type = :date_histogram
        @query = {
          @name => {
            @type => {}
          }
        }
      end

      # @param [Misc::BucketOrder] bucket_order
      # @return [DateHistogramAggregationBuilder], can be chained for ordering on multiple fields.
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
      # @return [DateHistogramAggregationBuilder]
      def calendar_interval interval
        @calendar_interval = interval
        self
      end

      # @return [String]
      def calendar_interval_expr
        @calendar_interval
      end

      # @param [Integer] doc_count
      # @return [DateHistogramAggregationBuilder]
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