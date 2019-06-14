module Aggregations
  module Buckets
    class DateRangeAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AbstractRangeHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper


      def initialize name
        @name = name.to_sym
        @type = :date_range
        @query = {
          @name => {
            @type => {}
          }
        }
      end
      
    end
  end
end