require_relative 'query_builder'
class FunctionScoreQueryBuilder < QueryBuilder

  NAME = "function_score"

  # attr_reader :function_query, :filter_functions, :score_mode, :boost_mode, :max_boost, :min_score, :score_builder

  def initialize query: nil, score_function: nil, filter_functions: []
    @function_query = query
    @score_builder = score_function
    @filter_functions = filter_functions
    @score_mode = nil
    @boost_mode = nil
    @max_boost = nil
    @min_score = nil
  end

  def query
    query = {}
    fs_query = self.common_query
    fs_query[:query] = @function_query.query if @function_query.present?
    fs_query[:functions] = @filter_functions.map{|ff| ff.query} if @filter_functions.present?
    fs_query[:score_mode] = @score_mode if @score_mode.present?
    fs_query[:boost_mode] = @boost_mode if @boost_mode.present?
    fs_query[:max_boost] = @max_boost if @max_boost.present?
    fs_query[:min_score] = @min_score if @min_score.present?
    fs_query.merge!(@score_builder.function) 
    query[name.intern] = fs_query
    return query
  end

########## Function Query ##########
=begin
  Query that specifies the documents to retrieve
=end
# Returns query
  def query_expr
    return @function_query
  end

########## Score Function ##########
=begin
  Function that defines how the documents will be scored.
=end
# Returns score_function
  def score_function_expr
    return @score_builder
  end

##########  BOOST MODE  #########################
=begin
  How the combined result of score functions will influence the final score together with the sub query score.
=end
=begin
  Returns the Boost mode for the query.
=end
  def boostmode_expr
    return @boostmode
  end
=begin
  Sets the Boost mode for the query.
=end
  def boostmode boostmode
    @boost_mode = boostmode.combine_function
    return self
  end


########## FILTER FUNCTIONS ##########
# Returns the filters and functions
  def filter_functions_expr
    return @filter_functions
  end

# Sets filter function/s to query
  def filter_function filter: nil, score_function: nil, weight: nil
    filter_function = self.class::FilterFunctionBuilder.new(filter: filter, score_function: score_function)
    filter_function.weight(weight) if weight.present?
    @filter_functions.append(filter_function)
    return self
  end

######### MAX BOOST ##########
=begin
  Returns the maximum boost that will be applied by function score.
=end
  def max_boost_expr
    return @max_boost
  end
=begin
  Sets the maximum boost that will be applied by function score.
=end
  def max_boost value
    raise "Max Boost cannot be nil value" if value.nil?
    @max_boost = value.to_f
    return self
  end


########## SCORE MODE ##########
=begin
  How results of individual score functions will be aggregated
=end
=begin
  Returns the score mode for the query.
=end
  def score_mode_expr
    return @score_mode
  end
=begin
  Sets the score mode for the query.
=end
  def score_mode score_mode
    @score_mode = score_mode.score_mode
    return self
  end


########## MIN SCORE ##########
=begin
  Used to exclude documents that do not meet a certain score threshold
=end
=begin
  Returns the min score for the query.
=end
  def min_score_expr
    return @min_score
  end
=begin
  Sets the min score for the query.
=end
  def min_score value
    raise "Min Score cannot be nil value" if value.nil?
    @min_score = value.to_f
    return self
  end


########## Filter Function Builder Class ##########
=begin
  Function to be associated with an optional filter, meaning it will be executed only for the documents that match the given filter.
=end
  class FilterFunctionBuilder
    include AttributesReader
    # attr_reader :filter, :score_builder, :weight

    def initialize filter: nil, score_function: nil
      @filter = filter
      @score_builder = score_function
    end

    def query
      query = {}
      query[:filter] = @filter.query if @filter.present?
      query[:weight] = @weight if @weight.present?
      query.merge!(@score_builder.query) if @score_builder.present?
      return query
    end


########## Filter Query ##########
=begin
    Returns filter query of the given filter function builder object.
=end
    def filter_expr
      return @filter
    end


########## Score Function ##########
=begin
    Returns score function of the given filter function builder object.
=end
    def score_function_expr
      return @score_builder
    end


########## Multiplicative Weight ##########
=begin
  Weight to be multiplied to function score before combining
=end
=begin
    Returns the weight for the filter function.
    
=end
    def weight_expr
      return @weight
    end
=begin
    Sets the weight for the filter function.
=end
    def weight value
      @weight = value.to_f
      return self
    end

  end
end