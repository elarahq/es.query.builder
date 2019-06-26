require_relative 'score_function_builder'
module FunctionScores
  class RandomScoreFunctionBuilder < ScoreFunctionBuilder

    NAME = 'random_score'
=begin
    @params:
      seed: Seed value based on which the random number will be generated
      field: Field value based on which the random number will be generated
=end

    def function
      function = {}
      rs_query = super
      rs_query[:field] = @field if field.present?
      rs_query[:seed] = @seed if seed.present?
      function[name.intern] = rs_query
      return function
    end

  ########## SEED VALUE ##########
  # Returns the seed value.
    def seed_expr
      return @seed
    end
  # Sets the seed value.
    def seed value
      @seed = value
      return self
    end

  ########## FIELD VALUE ##########
  # Returns the field value.
    def field_expr
      return @field
    end
  # Sets the field value.
    def field value
      @field = value
      return self
    end

  end
end