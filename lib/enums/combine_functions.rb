# frozen_string_literal: true

module Enums
  # Enumerator class for boost modes while combining aggregated function
  # scores together with the sub query score
  class CombineFunctions
    # @!visibility protected
    COMBINE_FUNCTIONS = { multiply: 'multiply', replace: 'replace', sum: 'sum',
                          avg: 'avg', max: 'max', min: 'min' }.freeze
    # @!visibility protected
    attr_reader :combine_function

    COMBINE_FUNCTIONS.each do |comb_fnctn, es_value|
      define_singleton_method(comb_fnctn) do
        return new(es_value)
      end
    end

    # @!scope class
    # @!method multiply
    # @return [CombineFunctions] CombineFunctions object
    #   corresponding to elasticsearch option of 'multiply'

    # @!scope class
    # @!method replace
    # @return [CombineFunctions] CombineFunctions object
    #   corresponding to elasticsearch option of 'replace'

    # @!scope class
    # @!method sum
    # @return [CombineFunctions] CombineFunctions object
    #   corresponding to elasticsearch option of 'sum'

    # @!scope class
    # @!method avg
    # @return [CombineFunctions] CombineFunctions object
    #   corresponding to elasticsearch option of 'avg'

    # @!scope class
    # @!method max
    # @return [CombineFunctions] CombineFunctions object
    #   corresponding to elasticsearch option of 'max'

    # @!scope class
    # @!method min
    # @return [CombineFunctions] CombineFunctions object
    #   corresponding to elasticsearch option of 'min'

    # @!visibility protected
    def initialize(combine_function)
      @combine_function = combine_function
    end
  end
end
