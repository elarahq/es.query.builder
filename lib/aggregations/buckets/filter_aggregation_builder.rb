module Aggregations
  module Buckets
    # Elasticsearch Filter Aggregation
    class FilterAggregationBuilder

      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      # @param [String] name : Aggregation name
      # @param [Queries::QueryBuilder] filter
      def initialize name:, filter:
        @name = name.intern
        @type = :filter
        @filter = filter
        @query = {
          @name => {
            @type => @filter
          }
        }
      end

      # @return [Queries::QueryBuilder]
      def filter_expr
        @filter
      end
      
    end
  end
end