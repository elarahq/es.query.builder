module Aggregations
  module Buckets
    # Elasticsearch Top Hits Aggregation
    class TopHitsAggregationBuilder

      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      ATTRIBUTES = [:size, :sort, :_source]

      # @param [String] name : Aggregation name
      def initialize name:
        @name = name.intern
        @type = :top_hits
        @query = {
          @name => {
            @type => {}
          }
        }
      end

      # @param [Integer] size
      # @return [TopHitsAggregationBuilder]
      def size size
        @size = size
        self
      end

      # @return [Integer]
      def size_expr
        @size
      end

      # @param [Sort::SortBuilder] sort : use SortBuilders factory
      # @return [TopHitsAggregationBuilder]
      def add_sort sort
        @sort ||= []
        @sort << sort
        self
      end

      # @return [Sort::SortBuilder]
      def sort_expr
        @sort
      end

      # @param [Array] include_list
      # @return [TopHitsAggregationBuilder]
      def source_include include_list
        @_source ||= {}
        @_source[:include] = include_list if include_list.present?
        self
      end

      # @param [Array] exclude_list
      # @return [TopHitsAggregationBuilder]
      def source_exclude exclude_list
        @_source ||= {}
        @_source[:exclude] = exclude_list if exclude_list.present?
        self
      end

      # @return [Array]
      def source_include_expr
        return [] unless @_source.present?
        @_source[:include]
      end

      # @return [Array]
      def source_exclude_expr
        return [] unless @_source.present?
        @_source[:exclude]
      end
      
    end
  end
end