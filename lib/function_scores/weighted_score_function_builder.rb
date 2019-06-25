require_relative 'score_function_builder'
class WeightedScoreFunctionBuilder < ScoreFunctionBuilder

  NAME = 'weight'
  DEFAULT_WEIGHT = 1

  def initialize
    @weight = DEFAULT_WEIGHT
  end

  def function
    function = {}
    function[name.intern] = @weight
    return function
  end

########## WEIGHT VALUE ##########
=begin
  Weight to be multiplied to function score before combining.
=end
=begin
  Returns the weight value
  Sets the weight if weight has been provided.
=end
  def weight_expr
    return @weight
  end
=begin
  Sets the weight value.
=end
  def weight value
    @weight = value
    return self
  end

end
