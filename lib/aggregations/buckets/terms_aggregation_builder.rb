module Aggregations
  module Buckets
    class TermsAggregationBuilder

      include ::Aggregations::Helpers::ValuesSourceAggregationHelper
      include ::Aggregations::Helpers::AbstractAggregationHelper
      include ::Aggregations::Helpers::AggregationQueryBuilderHelper

      ATTRIBUTES = [:size, :order, :include, :exclude, :min_doc_count]

      def initialize name
        @name = name.to_sym
        @type = :terms
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

      def add_order field, order=:desc
        order = (order.to_sym == :asc) ? :asc : :desc
        @order ||= []
        @order << {field.to_sym => order}
        self
      end

      def get_order
        @order
      end

      def include include_list
        @include = include_list
        self
      end

      def get_include
        @include
      end

      def exclude exclude_list
        @exclude = exclude_list
        self
      end

      def get_exclude
        @exclude
      end

      def min_doc_count doc_count
        @min_doc_count = doc_count
        self
      end

      def get_min_doc_count
        @min_doc_count
      end
      
    end
  end
end