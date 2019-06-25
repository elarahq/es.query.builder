# require_relative 'bool_query_builder'
# require 'match_query_builder'
# require 'term_query_builder'
# require 'terms_query_builder'
# require 'range_query_builder'
# require 'exists_query_builder'
# require 'constant_score_query_builder'
# require 'dis_max_query_builder'
# require 'function_score_query_builder'
# require 'nested_query_builder'
# require 'geo_distance_query'
# require 'match_all_query_builder'

class QueryBuilders

  def self.base_query *args
    return BaseQueryBuilder.new *args
  end

  def self.bool_query
    return BoolQueryBuilder.new
  end

  def self.match_query *args
    return MatchQueryBuilder.new *args
  end

  def self.term_query *args
    return TermQueryBuilder.new *args
  end

  def self.terms_query *args
    return TermsQueryBuilder.new *args
  end

  def self.range_query *args
    return RangeQueryBuilder.new *args
  end

  def self.exists_query *args
    return ExistsQueryBuilder.new *args
  end

  def self.constant_score_query *args
    return ConstantScoreQueryBuilder.new *args
  end

  def self.dis_max_query
    return DisMaxQueryBuilder.new
  end

  def self.function_score_query *args
    return FunctionScoreQueryBuilder.new *args
  end

  def self.nested_query *args
    return NestedQueryBuilder.new *args
  end

  def self.geo_distance_query
    return GeoDistanceQueryBuilder.new
  end

  def self.match_all_query
    return MatchAllQueryBuilder.new
  end

end