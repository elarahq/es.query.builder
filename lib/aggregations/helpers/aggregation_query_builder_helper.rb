module Aggregations
  module Helpers
    module AggregationQueryBuilderHelper

    	def get_name
    		@name
    	end

    	def get_type
    		@type
    	end

    	def get_query
        add_value_source_agg_builder if self.class.included_modules.include?(ValuesSourceAggregationHelper)
        add_abstract_agg_builder if self.class.included_modules.include?(AbstractAggregationHelper)
        add_abstract_range_builder if self.class.included_modules.include?(AbstractRangeHelper)
        add_class_attributes if ("#{self.class.name}::ATTRIBUTES".constantize rescue nil).present?
        @query
      end

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