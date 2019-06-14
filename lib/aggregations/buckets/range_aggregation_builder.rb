module Aggregations
  module Buckets
    class RangeAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AbstractRangeHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper


      def initialize name
        @name = name.to_sym
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