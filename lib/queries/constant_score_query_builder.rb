# frozen_string_literal: true

require_relative 'query_builder'
module Queries
  # A query that wraps a filter and simply returns a constant score
  # equal to the query boost for every document in the filter.
  class ConstantScoreQueryBuilder < QueryBuilder
    NAME = 'constant_score'

    # @params [QueryBuilder] inner_query query for whose
    #   matching documents constant score is to be set
    # @params [Numeric] boost boosting value
    def initialize(inner_query:)
      @inner_query = inner_query
    end

    # @return [Hash] serialized json query for the object
    def query
      query = {}
      cs_query = common_query
      cs_query[:filter] = @inner_query.query if @inner_query.present?
      query[name.intern] = cs_query
      query
    end

    # Returns inner_query
    # @!visibility protected
    def inner_query_expr
      @inner_query
    end
  end
end
