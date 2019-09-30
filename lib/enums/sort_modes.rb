# frozen_string_literal: true

module Enums
  # Elasticsearch supports sorting by array or multi-valued fields.
  # The SortMode option controls what array value is picked for sorting
  # the document it belongs to. The mode option can have the following values:  
  # *min* - Pick the lowest value.  
  # *max* - Pick the highest value.  
  # *sum* - Use the sum of all values as sort value.
  # Only applicable for number based array fields.  
  # *avg* - Use the average of all values as sort value.
  # Only applicable for number based array fields.  
  # *median* - Use the median of all values as sort value.
  # Only applicable for number based array fields.
  class SortModes
    # @!visibility protected
    SORT_MODES = { min: 'min', max: 'max',
                   sum: 'sum', avg: 'avg', median: 'median' }.freeze
    # @!visibility protected
    attr_reader :sort_mode

    # @!visibility protected
    SORT_MODES.each do |sort_mode, es_value|
      define_singleton_method(sort_mode) do
        return new(es_value)
      end
    end

    # @!scope class
    # @!method min
    # @return [SortModes] SortModes object
    #   corresponding to elasticsearch option of 'min'

    # @!scope class
    # @!method max
    # @return [SortModes] SortModes object
    #   corresponding to elasticsearch option of 'max'

    # @!scope class
    # @!method sum
    # @return [SortModes] SortModes object
    #   corresponding to elasticsearch option of 'sum'

    # @!scope class
    # @!method avg
    # @return [SortModes] SortModes object
    #   corresponding to elasticsearch option of 'avg'

    # @!scope class
    # @!method median
    # @return [SortModes] SortModes object
    #   corresponding to elasticsearch option of 'median'

    # @!visibility protected
    def initialize(sort_mode)
      @sort_mode = sort_mode
    end
  end
end
