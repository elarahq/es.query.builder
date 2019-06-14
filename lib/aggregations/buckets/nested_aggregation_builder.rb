module Aggregations
  module Buckets
    class NestedAggregationBuilder

      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper

      def initialize name, path
        @name = name.to_sym
        @type = :nested
        @path = path
        @query = {
          @name => {
            @type => {
              :path => path
            }
          }
        }
      end

      def get_path
        @path
      end

      
    end
  end
end