module Aggregations
  module Buckets
    class GeoGridAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper

      ATTRIBUTES = [:size, :precision]

      def initialize name
        @name = name.to_sym
        @type = :geohash_grid
        @query = {
          @name => {
            @type => {}
          }
        }
      end

      def size size
        @size = size
        self
      end

      def get_size
        @size
      end

      def precision precision
        @precision = precision
        self
      end

      def get_precision
        @precision
      end
      
    end
  end
end