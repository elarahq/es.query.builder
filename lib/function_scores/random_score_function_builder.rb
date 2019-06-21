require_relative 'score_function_builder'
class RandomScoreFunctionBuilder < ScoreFunctionBuilder

  NAME = 'random_score'

  def function
    function = {}
    rs_query = super
    rs_query[:field] = @field if field.present?
    rs_query[:seed] = @seed if seed.present?
    function[name.intern] = rs_query
    return function
  end

########## SEED VALUE ##########
=begin
  Seed value based on which the random number will be generated
=end
=begin
  Returns the seed value.
=end
  def seed_expr
    return @seed
  end
=begin
  Sets the seed value.
=end
  def seed value
    @seed = value
    return self
  end

########## FIELD VALUE ##########
=begin
  Field value based on which the random number will be generated
=end
=begin
  Returns the field value.
=end
  def field_expr
    return @field
  end
=begin
  Sets the field value.
=end
  def field value
    @field = value
    return self
  end

end