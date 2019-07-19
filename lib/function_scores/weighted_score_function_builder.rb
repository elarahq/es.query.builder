# frozen_string_literal: true

require_relative 'score_function_builder'
module FunctionScores
  # A query that multiplies the weight to the score.
  class WeightedScoreFunctionBuilder < ScoreFunctionBuilder
    # @!visibility protected
    NAME = 'weight'
    # @!visibility protected
    DEFAULT_WEIGHT = 1

    def initialize
      @weight = DEFAULT_WEIGHT
    end

    # @return [Hash] serialized json query for the object
    def function
      function = {}
      function[name.intern] = @weight
      function
    end

    # Returns the weight value
    # @!visibility protected
    def weight_expr
      @weight
    end

    # @params [Numeric] value weight for the weighted function
    # Sets the weight value.
    # @returns [WeightedScoreFunctionBuilder]
    #   modified self
    def weight(value)
      @weight = value
      self
    end
  end
end
