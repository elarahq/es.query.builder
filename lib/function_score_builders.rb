# Factory class for function scores.
class FunctionScoreBuilders

  def self.random_score_function
    return FunctionScoreBuilders::RandomScoreFunctionBuilder.new
  end

  def self.script_score_function *args
    return FilterScoreBuilders::ScriptScoreFunctionBuilder.new *args
  end

  def self.weighted_score_function
    return FilterScoreBuilders::WeightedScoreFunctionBuilder.new
  end
  
end