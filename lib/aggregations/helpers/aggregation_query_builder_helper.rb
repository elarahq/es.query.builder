# A helper module for aggregations, builds aggregation query from attributes.
module Aggregations
  module Helpers
    module AggregationQueryBuilderHelper

      # @return [String] : Aggregation name
      def name_expr
        @name
      end

      # @return [String] : Aggregation type
      def type_expr
        @type
      end

      # @return [Hash] : Aggregation query
      def query_expr
        add_value_source_agg_builder if self.class.included_modules.include?(ValuesSourceAggregationHelper)
        add_abstract_agg_builder if self.class.included_modules.include?(AbstractAggregationHelper)
        add_abstract_range_builder if self.class.included_modules.include?(AbstractRangeHelper)
        add_class_attributes if ("#{self.class.name}::ATTRIBUTES".constantize rescue nil).present?
        @query
      end

      private
      
      def add_value_source_agg_builder
        @query[@name][@type].merge!(value_source_agg_builder)
      end

      def add_class_attributes
        "#{self.class.name}::ATTRIBUTES".constantize.each do |attr|
          attr_inst = instance_variable_get("@#{attr.to_s}")
          @query[@name][@type][attr] = attr_inst if attr_inst.present?
        end
      end

      def add_abstract_agg_builder
        @query[@name].merge!(abstract_agg_builder)
      end

      def add_abstract_range_builder
        @query[@name][@type].merge!(abstract_range_builder)
      end

    end
  end
end