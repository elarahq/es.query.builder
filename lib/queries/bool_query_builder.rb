# frozen_string_literal: true

require_relative 'query_builder'
module Queries
  # A query that matches documents matching boolean combinations of
  # other queries. The bool query maps to Lucene BooleanQuery.
  # It is built using one or more boolean clauses,
  # each clause with a typed occurrence
  #    QueryComponents
  #       should: queries that may appear in the matching documents and
  #                will contribute to scoring
  #       must: queries that must appear in the matching documents and
  #             will contribute to scoring
  #       must_not: queries that must not appear in the matching documents and
  #                 will contribute to scoring
  #       filter: queries that must appear in the matching documents but
  #               don't contribute to scoring
  #       minimum_should_match: minimum should match as interger or percentage
  class BoolQueryBuilder < QueryBuilder
    NAME = 'bool'

    def initialize
      @should_queries = []
      @must_queries = []
      @mustnot_queries = []
      @filter_queries = []
      @minimum_should_match = nil
    end

    # @return [Hash] returns serialized query hash for this object
    def query
      query = {}
      bool_query = common_query
      bool_query[:should] = @should_queries.map(&:query)
      bool_query[:must] = @must_queries.map(&:query)
      bool_query[:must_not] = @mustnot_queries.map(&:query)
      bool_query[:filter] = @filter_queries.map(&:query)
      bool_query[:minimum_should_match] = @minimum_should_match
      bool_query[:boost] = @boost
      query[name.intern] = bool_query.compact
      query
    end

    # @!visibility protected
    # @return [Array<QueryBuilder>] the list of filter queries
    def filter_expr
      @filter_queries
    end

    # @param [QueryBuilder] query_builder
    #   filter query to be added
    # @return [BoolQueryBuilder] modified self
    # adds a filter query
    def filter(query_builder)
      if query_builder.is_a?(Array)
        @filter_queries += query_builder
      else
        @filter_queries.append(query_builder)
      end
      self
    end

    # @!visibility protected
    # @return [Array<QueryBuilder>] the list of should queries
    def should_expr
      @should_queries
    end

    # @param [QueryBuilder] query_builder
    #   should query to be added
    # @return [BoolQueryBuilder] modified self
    # adds a should query
    def should(query_builder)
      if query_builder.is_a?(Array)
        @should_queries += query_builder
      else
        @should_queries.append(query_builder)
      end
      self
    end

    # @!visibility protected
    # @return [Array<QueryBuilder>] the list of must queries
    def must_expr
      @must_queries
    end

    # @param [QueryBuilder] query_builder
    # must query to be added
    # @return [BoolQueryBuilder] modified self
    # adds a must query
    def must(query_builder)
      if query_builder.is_a?(Array)
        @must_queries += query_builder
      else
        @must_queries.append(query_builder)
      end
      self
    end

    # @!visibility protected
    # @return [Array<QueryBuilder>] the list of must_not queries
    def must_not_expr
      @mustnot_queries
    end

    # @param [QueryBuilder] query_builder
    #   must_not query to be added
    # @return [BoolQueryBuilder] modified self
    # adds a must_not query
    def must_not(query_builder)
      if query_builder.is_a?(Array)
        @mustnot_queries += query_builder
      else
        @mustnot_queries.append(query_builder)
      end
      self
    end

    # @!visibility protected
    # @return [Integer] minimum should match value for this query
    def minimum_should_match_expr
      @minimum_should_match
    end

    # @param [Integer] value
    #   minimum number of should conditions to fulfill
    # @return [BoolQueryBuilder] modified self
    # sets the minimum should match value
    # for the given query object
    def minimum_should_match(value)
      raise 'Minimum Should match cannot be nil' if value.nil?

      @minimum_should_match = value
      self
    end

    # @return [Boolean] returns true iff this query builder has at least one
    #   should, must, must not or filter clause
    def clauses?
      shuld_clause = @should_queries.present?
      must_clause = @must_queries.present?
      mustnot_clause = @mustnot_queries.present?
      filter_clause = @filter_queries.present?
      shuld_clause && must_clause && mustnot_clause && filter_clause
    end
  end
end
