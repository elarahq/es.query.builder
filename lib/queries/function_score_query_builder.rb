class FunctionScoreQueryBuilder < QueryBuilder

  NAME = "function_score"

  # attr_reader :function_query, :function_filters, :score_mode, :boost_mode, :max_boost, :min_score, :score_builder

  def initialize *args
    @function_filters = []
    args.each do|arg|
      case arg.class.to_s
      when 'QueryBuilder'
        @function_query = arg
      when 'ScoreFunctionBuilder'
        @score_builder = arg
      when 'FunctionScoreQuerytBuilder::FilterFunctionBuilder'
        @function_filters.append(arg)
      else
        raise "#{arg} is not a valid param for filter score query builder"
      end
    end
    @score_mode = nil
    @boost_mode = nil
    @max_boost = nil
    @min_score = nil
  end

  def query
    query = {}
    fs_query = self.common_query
    fs_query[:query] = @function_query if @function_query.present?
    fs_query[:functions] = @function_filters.map{|ff| ff.query} if @function_filters.present?
    fs_query[:score_mode] = @score_mode if @score_mode.present?
    fs_query[:boost_mode] = @boost_mode if @boost_mode.present?
    fs_query[:max_boost] = @max_boost if @max_boost.present?
    fs_query[:min_score] = @min_score if @min_score.present?
    fs_query.merge!(@score_builder.function) 
    query[name.intern] = fs_query
    return query
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
=begin
  Returns the filters and functions
=end
  def filter_function_builders
    return @function_filters
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

    # attr_reader :filter, :score_builder, :weight

    def initialize *args
      args.each do |arg|
        case arg.class.to_s
        when 'QueryBuilder'
          @filter = arg
        when 'ScoreFunctionBuilder'
          @score_builder = arg
        else
          raise "#{arg} is not a valid param for filter function builder"
        end
      end
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
    def filter
      return @filter
    end


########## Score Function ##########
=begin
    Returns score function of the given filter function builder object.
=end
    def score_function
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
      raise Errors::NilError.new('Filter function weight') if value.nil?
      @weight = value.to_f
      return self
    end

  end
end