require_relative 'score_function_builder'
module FunctionScores
  class ScriptScoreFunctionBuilder < ScoreFunctionBuilder

    NAME = 'script_score'

    def initialize script:
      @script = script
    end

    def function
      function = {}
      ss_query = super
      ss_query[:script] = script.settings
      function[name.intern] = ss_query
      return function
    end

    def script_expr
      return @script
    end

  end
end
