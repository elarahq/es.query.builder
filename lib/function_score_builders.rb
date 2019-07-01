# frozen_string_literal: true

# Factory class for function scores.
class FunctionScoreBuilders
  # @return [FunctionScores::RandomScoreFunctionBuilder]
  #   random_score_function_builder object
  def self.random_score_function
    FunctionScores::RandomScoreFunctionBuilder.new
  end

  # @params [Scripts::Script] script object for the function
  # @return [FunctionScores::ScriptScoreFunctionBuilder]
  #   script_score_function_builder object with the
  #   provided script
  def self.script_score_function(*args)
    FunctionScores::ScriptScoreFunctionBuilder.new(*args)
  end

  # @return [FunctionScores::WeightedScoreFunctionBuilder]
  #   weighted_score_function_builder object
  def self.weighted_score_function
    FunctionScores::WeightedScoreFunctionBuilder.new
  end
end
