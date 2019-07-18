# frozen_string_literal: true

module Queries
  # General methods for query classes
  module AbstractQueryBuilder
    # @params [QueryBuilder] query query object to be matched
    # Checks if both the query objects are same
    # @return [Boolean] if both queries are same
    def do_equals?(query)
      # Checks if given query object is same as this query object
      self.query == query.query
    end

    # @!visibility protected
    def common_query
      common_query = {}
      common_query[:boost] = @boost if @boost.present?
      common_query
    end

    def name
      self.class::NAME.to_s
    end

    # @!visibility protected
    def wrap_query
      query = { query: self.query }
      query
    end
  end
end
