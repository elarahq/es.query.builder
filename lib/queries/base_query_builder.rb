# frozen_string_literal: true

require_relative 'query_builder'
module Queries
  # Wraps a query keyword around the query of the given object
  class BaseQueryBuilder < QueryBuilder
    NAME = 'query'

    # @params [QueryBuilder] inner_query
    #   query object whose query is to be wrapped around query keyword
    def initialize(inner_query:)
      @inner_query = inner_query
    end

    # @return [Hash] serialized query hash for the object
    def query
      query = { name.intern => inner_query.query }
      query
    end

    # @!visibility protected
    # Returns inner_query
    def inner_query_expr
      @inner_query
    end
  end
end
