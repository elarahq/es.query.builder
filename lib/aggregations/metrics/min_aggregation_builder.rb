module Aggregations
  module Metrics
    # Elasticsearch Min Aggregation
    class MinAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      # @param [String] name : Aggregation name
      def initialize name:
        @name = name.intern
        @type = :min
        @query = {
          @name => {
            @type => {}
          }
        }
      end
      
    end
  end
end