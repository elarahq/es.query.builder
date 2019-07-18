# frozen_string_literal: true

require_relative 'score_function_builder'
module FunctionScores
  # A function that computes a random score for the matched documents
  #     Query Components:
  #       seed: Seed value based on which the random number will be generated
  #       field: Field value based on which the random number will be generated
  class RandomScoreFunctionBuilder < ScoreFunctionBuilder
    # @!visibility protected
    NAME = 'random_score'

    # @return [Hash] serailized json query for the object
    def function
      function = {}
      rs_query = super
      rs_query[:field] = @field if field.present?
      rs_query[:seed] = @seed if seed.present?
      function[name.intern] = rs_query
      function
    end

    # @!visibility protected
    # Returns the seed value.
    def seed_expr
      @seed
    end

    # @params [Numeric] Seed Value
    # Sets the seed value.
    # @return [RandomScoreFunctionBuilder]
    # modified self
    def seed(value)
      @seed = value
      self
    end

    # @!visibility protected
    # Returns the field value.
    def field_expr
      @field
    end

    # @params [String] field name
    # Sets the field value.
    # @return [RandomScoreFunctionBuilder]
    # modified self
    def field(value)
      @field = value
      self
    end
  end
end
