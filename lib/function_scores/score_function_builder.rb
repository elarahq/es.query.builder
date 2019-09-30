# frozen_string_literal: true

module FunctionScores
  # Base class for function score builder classes
  class ScoreFunctionBuilder
    include AttributesReader

    # @return [Hash] serialized json query for the object
    def function
      {}
    end

    # Elasticsearch key for the score function class.
    # @return [String] es key for the score function class
    def name
      self.class::NAME
    end
  end
end
