module Aggregations
  module Buckets
    class DateHistogramAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper

      ATTRIBUTES = [:order, :interval, :min_doc_count]

      def initialize name
        @name = name.to_sym
        @type = :date_histogram
        @query = {
          @name => {
            @type => {}
          }
        }
      end

      def add_order field, order=:desc
        @order ||= []
        @order << {field => order}
        self
      end

      def get_order
        @order
      end

      def interval interval
        @interval = interval
        self
      end

      def get_interval
        @interval
      end

      def min_doc_count doc_count
        @min_doc_count = doc_count
        self
      end

      def get_min_doc_count
        @min_doc_count
      end

      
    end
  end
end