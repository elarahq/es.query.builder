require_relative 'bool_query_builder'
require 'match_query_builder'
require 'term_query_builder'
require 'terms_query_builder'
require 'range_query_builder'
require 'exists_query_builder'
require 'constant_score_query_builder'
require 'dis_max_query_builder'
require 'function_score_query_builder'
require 'nested_query_builder'
require 'geo_distance_query'
require 'match_all_query_builder'

class QueryBuilders

	def self.bool_query
		return BoolQueryBuilder.new
	end

	def self.match_query
		return MatchQueryBuilder.new
	end

	def self.term_query
		return TermQueryBuilder.new
	end

	def self.terms_query
		return TermsQueryBuilder.new
	end

	def self.range_query
		return RangeQueryBuilder.new
	end

	def self.exists_query
		return ExistsQueryBuilder.new
	end

	def self.constant_score_query
		return ConstantScoreQueryBuilder.new
	end

	def self.dis_max_query
		return DisMaxQueryBuilder.new
	end

	def self.functionScoreQuery
		return FunctionScoreQueryBuilder.new
	end

	def self.nestedQuery
		return NestedQueryBuilder.new
	end

	def self.geoDistanceQuery
		return GeoDistanceQueryBuilder.new
	end

	def self.matchAllQuery
		return MatchAllQueryBuilder.new
	end

end