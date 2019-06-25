# Factory class for function scores.
class FunctionScoreBuilders

  def self.random_score_function
    return RandomScoreFunctionBuilder.new
  end

  def self.script_score_function *args
    return ScriptScoreFunctionBuilder.new *args
  end

  def self.weighted_score_function
    return WeightedScoreFunctionBuilder.new
  end
  
end