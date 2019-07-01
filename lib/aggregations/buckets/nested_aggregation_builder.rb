module Aggregations
  module Buckets
    # Elasticsearch Nested Aggregation
    class NestedAggregationBuilder

      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      # @param [String] name : Aggregation name
      # @param [String] path
      def initialize name:, path:
        @name = name.intern
        @type = :nested
        @path = path
        @query = {
          @name => {
            @type => {
              :path => path
            }
          }
        }
      end

      # @return [String]
      def path_expr
        @path
      end

      
    end
  end
end