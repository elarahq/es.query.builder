# A helper module for aggregations, builds aggregation query from attributes.
module Aggregations
  module Helpers
    module AggregationQueryBuilderHelper

      OBJECT_ARRAY_SETTINGS_FIELDS = [:order]
      OBJECT_ARRAY_QUERY_FIELDS = [:sort]

      # @return [String] : Aggregation name
      def name_expr
        @name.to_s
      end

      # @return [String] : Aggregation type
      def type_expr
        @type.to_s
      end

      # @return [Hash] : Aggregation query
      def query
        add_value_source_agg_builder if self.class.included_modules.include?(ValuesSourceAggregationHelper)
        add_abstract_agg_builder if self.class.included_modules.include?(AbstractAggregationHelper)
        add_abstract_range_builder if self.class.included_modules.include?(AbstractRangeHelper)
        add_class_attributes if ("#{self.class.name}::ATTRIBUTES".constantize rescue nil).present?
        @query
      end

      alias_method :query_expr, :query

      private
      
      def add_value_source_agg_builder
        @query[@name][@type].merge!(value_source_agg_builder)
      end

      def add_class_attributes
        "#{self.class.name}::ATTRIBUTES".constantize.each do |attr|
          attr_inst = instance_variable_get("@#{attr.to_s}")
          if attr_inst.present?
            if OBJECT_ARRAY_SETTINGS_FIELDS.include?(attr)
              @query[@name][@type][attr] = attr_inst.map{|obj| obj.settings}
            elsif OBJECT_ARRAY_QUERY_FIELDS.include?(attr)
              @query[@name][@type][attr] = attr_inst.map{|obj| obj.query}
            else
              @query[@name][@type][attr] = attr_inst
            end
          end
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