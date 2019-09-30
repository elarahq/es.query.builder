module Aggregations
  module Buckets
    # Elasticsearch Reverse Nested Aggregation
    class ReverseNestedAggregationBuilder

      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      # @param [String] name : Aggregation name
      def initialize name:
        @name = name.intern
        @type = :reverse_nested
        @query = {
          @name => {
            @type => {}
          }
        }
      end
      
    end
  end
end
