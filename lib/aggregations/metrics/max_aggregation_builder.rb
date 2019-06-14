module Aggregations
  module Metrics
    class MaxAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper

      def initialize name
        @name = name.to_sym
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