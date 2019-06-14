module Aggregations
  module Buckets
    class FilterAggregationBuilder

      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper

      def initialize name, filter
        @name = name.to_sym
        @type = :filter
        @filter = filter
        @query = {
          @name => {
            @type => @filter
          }
        }
      end

      def get_filter
        @filter
      end
      
    end
  end
end