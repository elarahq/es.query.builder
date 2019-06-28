# Script sort builder allows to sort based on a custom script expression.
require_relative 'sort_builder'
module Sort
  class ScriptSortBuilder < SortBuilder

    NAME = '_script'

=begin
    @params:
      script: Script used in this sort.
      type: Script sort type used in this sort, can be (number, string).
      nested_sort: Nested path within current object.
      sort_mode: Defines which distance to use for sorting in the case a document contains multiple values.
=end

    def initialize script:, type:
      @script = script
      @type = type.script_sort_type
      @nested_sort = nil
      @sort_mode = nil
    end

    def query
      query = {}
      script_query = self.common_query
      script_query[:script] = @script.settings
      script_query[:type] = @type
      script_query[:nested] = @nested_sort.query if @nested_sort.present?
      script_sort[:sort_mode] = @sort_mode if @sort_mode.present?
      query[name.intern] = script_query
      return query
    end

  # returns script
    def script_expr
      return @script
    end

  # returns type
    def type_expr
      return @type
    end

  # returns nested_sort
    def nested_sort_expr
      return @nested_sort
    end
  # sets nested_sort
    def nested_sort nested_sort
      @nested_sort = nested_sort
      return self
    end

  # returns sort_mode
    def sort_mode_expr
      return @sort_mode
    end
  # sets sort_mode
    def sort_mode sort_mode
      @sort_mode = sort_mode.sort_mode
      return self
    end

    class ScriptSortTypes

      SCRIPT_SORT_TYPES = {number: "number", string: "string"}

      attr_reader :script_sort_type

      SCRIPT_SORT_TYPES.each do |script_type, es_value|
        define_singleton_method(script_type) do
          return self.new(es_value)
        end
      end

      def initialize script_type
        @script_sort_type = script_type
      end

    end

  end
end