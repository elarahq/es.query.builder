# frozen_string_literal: true

module Enums
  # Enumerator class for types of scripts in sorting.
  class ScriptSortTypes
    # @!visibility protected
    SCRIPT_SORT_TYPES = { number: 'number', string: 'string' }.freeze
    # @!visibility protected
    attr_reader :script_sort_type
    # @!visibility protected
    SCRIPT_SORT_TYPES.each do |script_type, es_value|
      define_singleton_method(script_type) do
        return new(es_value)
      end
    end

    # @!scope class
    # @!method number
    # @return [ScriptSortTypes] ScriptSortTypes object
    #   corresponding to elasticsearch option of 'multiply'

    # @!scope class
    # @!method string
    # @return [ScriptSortTypes] ScriptSortTypes object
    #   corresponding to elasticsearch option of 'string'

    # @!visibility protected
    def initialize(script_type)
      @script_sort_type = script_type
    end
  end
end
