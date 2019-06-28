# A helper module for aggregations, defines field, script, missing attributes.
module Aggregations
  module Helpers
    module ValuesSourceAggregationHelper

      # helper method to add values source attributes to aggregation.
      def value_source_agg_builder
        builder = {}
        builder[:field] = @field
        builder[:script] = @script if @script.present?
        builder[:missing] = @missing if @missing.present?
        builder
      end

      # @param [String] field
      # @return [calling class object]
      def field field
        @field = field
        self
      end

      # @return [String]
      def field_expr
        @field
      end

      # @param [Script] script
      # @return [calling class object]
      def script script
        @script = script.get_script
        self
      end

      # @return [Script]
      def script_expr
        @script
      end

      # @param [String]
      # @return [calling class object]
      def missing missing
        @missing = missing
        self
      end

      # @return [String]
      def missing_expr
        @missing
      end

    end
  end
end