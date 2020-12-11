# frozen_string_literal: true

# Factory class for query classes
class QueryBuilders
  # @return [Queries::BoolQueryBuilder]
  #   bool_query_builder object
  def self.bool_query
    Queries::BoolQueryBuilder.new
  end

  # @params [String] field_name
  #   field on which match query to be performed
  # @params [String] value value to be matched
  # @return [Queries::MatchQueryBuilder]
  #   match_query_builder object
  def self.match_query(*args)
    Queries::MatchQueryBuilder.new(*args)
  end

  # @params [String] field_name
  #   field on which term query to be performed
  # @params [String] value value to be matched
  # @return [Queries::TermQueryBuilder]
  #   term_query_builder object
  def self.term_query(*args)
    Queries::TermQueryBuilder.new(*args)
  end

  # @params [String] field_name
  #   field on which terms query to be performed
  # @params [String] values values to be matched
  # @return [Queries::TermsQueryBuilder]
  #   terms_query_builder object
  def self.terms_query(*args)
    Queries::TermsQueryBuilder.new(*args)
  end

  # @params [String] field_name
  #   field on which range query to be performed
  # @return [Queries::RangeQueryBuilder]
  #   range_query_builder object
  def self.range_query(*args)
    Queries::RangeQueryBuilder.new(*args)
  end

  # @params [String] field_name
  #   field on which exists query to be performed
  # @return [Queries::ExistsQueryBuilder]
  #   exists_query_builder object
  def self.exists_query(*args)
    Queries::ExistsQueryBuilder.new(*args)
  end

  # @params [Queries::QueryBuilder] inner_query
  #   query to be wrapped by constant score query
  # @return [Queries::ConstantScoreQueryBuilder]
  #   constant_score_query_builder object
  def self.constant_score_query(*args)
    Queries::ConstantScoreQueryBuilder.new(*args)
  end

  # @return [Queries::DisMaxQueryBuilder]
  #   dis_max_query_builder object
  def self.dis_max_query
    Queries::DisMaxQueryBuilder.new
  end

  # @params [Queries::QueryBuilder] query
  #   query part in the function score query object
  # @params [FunctionScores::ScoreFunctionBuilder] score_function
  #   score_function for the function score query object
  # @params [Queries::FunctionScoreQueryBuilder::FilterFunctionBuilder]
  #   filter_functions filter functions for the function score query object
  # @return [Queries::FunctionScorehQueryBuilder]
  #   function_score_query_builder object
  def self.function_score_query(*args)
    Queries::FunctionScoreQueryBuilder.new(*args)
  end

  # @params [String] path
  #   path to the nested field
  # @params [Queries::QueryBuilder] inner_query
  #   query on the nested field
  # @params [Enums::ScoreModes] score_mode
  #   score_mode for the matched documents
  # @return [Queries::NestedQueryBuilder]
  #   nested_query_builder object
  def self.nested_query(*args)
    Queries::NestedQueryBuilder.new(*args)
  end

  # @params [String] field_name
  #   field on which exists query to be performed
  # @return [Queries::GeoDistanceQueryBuilder]
  #   geo_distance_query_builder object
  def self.geo_distance_query(*args)
    Queries::GeoDistanceQueryBuilder.new(*args)
  end

  # @return [Queries::MAtchAllQueryBuilder]
  #   match_all_query_builder object
  def self.match_all_query
    Queries::MatchAllQueryBuilder.new
  end

  # @params [String] field_name
  #   field on which exists query to be performed
  # @return [Queries::GeoDistanceQueryBuilder]
  #   geo_bounding_box_query_builder object
  def self.geo_bounding_box_query(*args)
    Queries::GeoBoundingBoxQueryBuilder.new(*args)
  end

end
