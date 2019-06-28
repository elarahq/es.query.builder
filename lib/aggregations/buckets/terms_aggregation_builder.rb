module Aggregations
  module Buckets
    # A multi-bucket value source based aggregation where buckets are dynamically built - one per unique value.
    class TermsAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper
      include ::AttributesReader

      ATTRIBUTES = [:size, :order, :include, :exclude, :min_doc_count]

      # @param [String] name : Aggregation name
      def initialize name:
        @name = name.to_sym
        @type = :terms
        @query = {
          @name => {
            @type => {}
          }
        }
      end

      # @param [Integer] size
      # @return [TermsAggregationBuilder]
      def size size
        @size = size
        self
      end

      # @return [Integer]
      def size_expr
        @size
      end

      # @param [String] field
      # @param [Symbol] order : (:asc/:desc), defaults to :desc.
      # @return [TermsAggregationBuilder], can be chained for ordering on multiple fields.
      def add_order field, order=:desc
        order = (order.to_sym == :asc) ? :asc : :desc
        @order ||= []
        @order << {field.to_sym => order}
        self
      end

      # @return [Array]
      def order_expr
        @order
      end

      # @param [Array] include list
      # @return [TermsAggregationBuilder]
      def include include_list
        @include = include_list
        self
      end

      # @return [Array]
      def include_expr
        @include
      end

      # @param [Array] exclude list
      # @return [TermsAggregationBuilder]
      def exclude exclude_list
        @exclude = exclude_list
        self
      end

      # @return [Array]
      def exclude_expr
        @exclude
      end

      # @param [Integer] min doc count
      # @return [TermsAggregationBuilder]
      def min_doc_count doc_count
        @min_doc_count = doc_count
        self
      end

      # @return [Integer]
      def min_doc_count_expr
        @min_doc_count
      end
      
    end
  end
end