module Aggregations
  module Metrics
    # Elasticsearch Max Aggregation
    class MaxAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      # @param [String] name : Aggregation name
      def initialize name:
        @name = name.intern
        @type = :max
        @query = {
          @name => {
            @type => {}
          }
        }
      end
      
    end
  end
end