module Aggregations
  module Metrics
    # Elasticsearch Avg Aggregation
    class AvgAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      # @param [String] name : Aggregation name
      def initialize name:
        @name = name.intern
        @type = :avg
        @query = {
          @name => {
            @type => {}
          }
        }
      end
      
    end
  end
end