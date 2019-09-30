module Aggregations
  module Buckets
    # Elasticsearch Filter Aggregation
    class FiltersAggregationBuilder

      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      # @param [String] name : Aggregation name
      # @param [Queries::QueryBuilder] filter
      def initialize name:, filters:
        @name = name.intern
        @type = :filters
        @filters = filters
        @query = {
          @name => {
            @type => {
              @type => @filters
            }
          }
        }
      end

      # @return [Queries::QueryBuilder]
      def filters_expr
        @filters
      end
      
    end
  end
end