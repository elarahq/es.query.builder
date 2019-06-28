module Aggregations
  module Buckets
    # Elasticsearch Range Aggregation
    class RangeAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AbstractRangeHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      # @param [String] name : Aggregation name
      def initialize name:
        @name = name.intern
        @type = :range
        @query = {
          @name => {
            @type => {}
          }
        }
      end
      
    end
  end
end