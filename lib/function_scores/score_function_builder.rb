module FunctionScores  
  class ScoreFunctionBuilder
    include AttributesReader

    def function
      {}
    end

  # The name of this score function.
    def name
      return self.class::NAME
    end

  end
end