# frozen_string_literal: true

require_relative 'query_builder'
module Queries
  # A query that generates the union of documents produced
  # by its sub-queries, and that scores each document
  # with the maximum score for that document as produced by any sub-query,
  # plus a tie breaking increment for any additional matching sub-queries.
  class DisMaxQueryBuilder < QueryBuilder
    # @!visibility protected
    DEFAULT_TIE_BREAKER = 0.0
    # @!visibility protected
    NAME = 'dis_max'

    def initialize
      @queries = []
      @tie_breaker = DEFAULT_TIE_BREAKER
    end

    def query
      query = {}
      dm_query = common_query
      dm_query[:queries] = @queries.map(&:query) if @queries.present?
      dm_query[:tie_breaker] = @tie_breaker
      query[name.intern] = dm_query
      query
    end

    # an immutable list copy of the current sub-queries of this disjunction
    # @!visibilty protected
    def inner_queries_expr
      @queries
    end

    # returns the tie breaker value
    # @!visibility protected
    def tie_breaker_expr
      @tie_breaker
    end

    # @params [Numeric] value tie_breaker value
    #   tie_breaker:
    #   the score of each non-maximum disjunct for a document is multiplied
    #   by this weight and added into the final score. If non-zero,
    #   the value should be small, on the order of 0.1, which says that
    #   10 occurrences of word in a lower-scored field that is also in a
    #   higher scored field is just as good as a unique word in the lower
    #   scored field (i.e., one that is not in any higher scored field).
    # adds the tie_breaker value
    # @return [DisMaxQueryBuilder]
    #   modified self
    def tie_breaker(value)
      raise 'Tie Breaker value is nil' if value.nil?

      @tie_breaker = value
      self
    end

    # @params [QueryBuilder] query subquery to be added to the dismax query
    # add a sub-query to this disjunction
    # @return [DisMaxQueryBuilder]
    #   modified self
    def add(query)
      raise 'Query for Dismax is nil' if query.nil?

      @queries.append(query)
      self
    end
  end
end
