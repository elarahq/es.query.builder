module Aggregations
  module Helpers
    module ValuesSourceAggregationHelper

      def value_source_agg_builder
        builder = {}
        builder[:field] = @field
        builder[:script] = @script if @script.present?
        builder[:missing] = @missing if @missing.present?
        builder
      end

      def field field
        @field = field
        self
      end

      def get_field
        @field
      end


      def script script
        @script = script.get_script
        self
      end

      def get_script
        @script
      end

      def missing missing
        @missing = missing
        self
      end

      def get_missing
        @missing
      end

    end
  end
end