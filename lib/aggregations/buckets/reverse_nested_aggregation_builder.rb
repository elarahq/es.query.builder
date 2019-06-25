module Aggregations
  module Buckets
    class ReverseNestedAggregationBuilder

      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper

      def initialize name
        @name = name.to_sym
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
