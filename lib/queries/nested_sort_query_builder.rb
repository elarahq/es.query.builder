require_relative 'query_builder'
module Queries
  class NestedSortQueryBuilder < QueryBuilder

    NAME = "nested"

    attr_reader :path, :inner_query

=begin
    @params:
      path: The query path points to the nested object path.
      inner_query: query includes the query that will run on the nested docs matching the direct path, and joining with the root parent docs

    Any fields referenced inside the query must use the complete path (fully qualified)
=end
    def initialize path:, inner_query:
      @path = path
      @inner_query = inner_query
    end

    def query
      nested_query = self.common_query
      nested_query[:path] = @path if @path.present?
      nested_query[:filter] = @inner_query.query if @inner_query.present?
      return nested_query
    end

  # returns path
    def path_expr
      return @path
    end

  # returns inner_query
    def inner_query_expr
      return @inner_query
    end

  # returns score_mode
    def score_mode_expr
      return @score_mode
    end

  end
end