# frozen_string_literal: true

require_relative 'score_function_builder'
module FunctionScores
  # A function that uses a script to compute or influence the
  # score of documents that match with the inner query or filter.
  class ScriptScoreFunctionBuilder < ScoreFunctionBuilder
    # @!visibility protected
    NAME = 'script_score'

    # @params [Misc::Script] script script object for the function
    def initialize(script:)
      @script = script
    end

    # @return [Hash] serialized json query for the object
    def function
      function = {}
      ss_query = super
      ss_query[:script] = script.settings
      function[name.intern] = ss_query
      function
    end

    # @!visibility protected
    def script_expr
      @script
    end
  end
end
