module Aggregations
  module Buckets
    # Elasticsearch GeoHash grid Aggregation
    class GeoGridAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      ATTRIBUTES = [:size, :precision]

      # @param [String] name : Aggregation name
      def initialize name:
        @name = name.intern
        @type = :geohash_grid
        @query = {
          @name => {
            @type => {}
          }
        }
      end

      # @param [Integer] size
      # @return [GeoGridAggregationBuilder]
      def size size
        @size = size
        self
      end

      # @return [Integer]
      def size_expr
        @size
      end

      # @param [Integer] precision
      # @return [GeoGridAggregationBuilder]
      def precision precision
        @precision = precision
        self
      end

      # @return [Integer]
      def precision_expr
        @precision
      end
      
    end
  end
end