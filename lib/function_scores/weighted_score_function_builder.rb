require_relative 'score_function_builder'
module FunctionScores
  class WeightedScoreFunctionBuilder < ScoreFunctionBuilder

    NAME = 'weight'
    DEFAULT_WEIGHT = 1

=begin
      @params:
        weight: Weight to be multiplied to function score before combining.
=end

    def initialize
      @weight = DEFAULT_WEIGHT
    end

    def function
      function = {}
      function[name.intern] = @weight
      return function
    end

  ########## WEIGHT VALUE ##########
  # Returns the weight value
    def weight_expr
      return @weight
    end
  # Sets the weight value.
    def weight value
      @weight = value
      return self
    end

  end
end
