require_relative 'query_builder'
module Queries
  class FunctionScoreQueryBuilder < QueryBuilder

    NAME = "function_score"

=begin
    @params:
      query: query that specifies the documents to retrieve
      filter_functions: function to be associated with an optional filter, meaning it will be executed only for the documents that match the given filter
      score_mode: how results of individual score functions will be aggregated
      boost_mode: how the combined result of score functions will influence the final score together with the sub query score
      max_boost: maximum boost that will be applied by function score
      min_score: used to exclude documents that do not meet a certain score threshold
      score_function: function that defines how the documents will be scored
=end

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
  # returns query
    def query_expr
      return @function_query
    end

  ########## Score Function ##########
  # returns score_function
    def score_function_expr
      return @score_builder
    end

  ##########  BOOST MODE  #########################
  # returns the Boost mode for the query
    def boostmode_expr
      return @boostmode
    end
  # sets the Boost mode for the query.
    def boostmode boostmode
      @boost_mode = boostmode.combine_function
      return self
    end


  ########## FILTER FUNCTIONS ##########
  # returns the filters and functions
    def filter_functions_expr
      return @filter_functions
    end
  # sets filter function/s to query
    def filter_function filter_function
      @filter_functions.append(filter_function)
      return self
    end

  ######### MAX BOOST ##########
  # returns max_boost
    def max_boost_expr
      return @max_boost
    end
  # sets max_boost
    def max_boost value
      raise "Max Boost cannot be nil value" if value.nil?
      @max_boost = value.to_f
      return self
    end


  ########## SCORE MODE ##########
  # returns the score mode for the query.
    def score_mode_expr
      return @score_mode
    end
  # sets the score mode for the query.
    def score_mode score_mode
      @score_mode = score_mode.score_mode
      return self
    end


  ########## MIN SCORE ##########
  # returns the min score for the query
    def min_score_expr
      return @min_score
    end
  # sets the min score for the query
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

=begin
      @params:
        filter: filter to select the documents
        weight: weight to be multiplied to function score before combining
        score_function: function for scoring matching documents
=end

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
  # returns filter query of the given filter function builder object
      def filter_expr
        return @filter
      end


  ########## Score Function ##########
  # returns score function of the given filter function builder object
      def score_function_expr
        return @score_builder
      end


  ########## Multiplicative Weight ##########
  # returns the weight for the filter function
      def weight_expr
        return @weight
      end
  # sets the weight for the filter function
      def weight value
        @weight = value.to_f
        return self
      end

    end
  end
end