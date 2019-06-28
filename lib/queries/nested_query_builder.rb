require_relative 'query_builder'

module Queries
  # Nested query allows to query nested objects / docs (see nested mapping).
  # The query is executed against the nested objects / docs as if they were
  # indexed as separate docs (they are, internally) and resulting in the
  # root parent doc (or parent nested mapping).
  class NestedQueryBuilder < QueryBuilder
    NAME = 'nested'.freeze

    attr_reader :path, :inner_query, :score_mode

    # @param [String] path : Points to the nested object path.
    #
    # @param [Integer] score_mode : (avg|sum|min|max|nil), defaults to avg.
    # Allows to set how inner children matching affects scoring of parent.
    #
    # @param [QueryBuilder] inner_query : Includes the query that will run on
    #                                     the nested docs matching the direct
    #                                     path, and joining with the root parent
    #                                     docs. Any fields referenced inside
    #                                     the query must use the complete path
    #                                     (fully qualified).
    def initialize(path:, inner_query:, score_mode: nil)
      @path = path
      @inner_query = inner_query
      @score_mode = score_mode.score_mode
    end

    # @return [Hash]
    def query
      query = {}
      nested_query = common_query
      nested_query[:path] = @path if @path.present?
      nested_query[:query] = @inner_query.query if @inner_query.present?
      nested_query[:score_mode] = @score_mode if @score_mode.present?
      query[name.intern] = nested_query
      query
    end

    # @return [String]
    def path_expr
      @path
    end

    # @return [Query]
    def inner_query_expr
      @inner_query
    end

    # @return [String]
    def score_mode_expr
      @score_mode
    end
  end
end