=begin
  A query that matches documents matching boolean combinations of other queries. The bool query maps to Lucene BooleanQuery.
  It is built using one or more boolean clauses, each clause with a typed occurrence
=end
require_relative 'query_builder'
module Queries
  class BoolQueryBuilder < QueryBuilder
    
    ADJUST_PURE_NEGATIVE_DEFAULT = true
    NAME = "bool"

=begin
    @params:
      should: queries that may appear in the matching documents and will contribute to scoring
      must: queries that must appear in the matching documents and will contribute to scoring
      must_not: queries that must not appear in the matching documents and will contribute to scoring
      filter: queries that must appear in the matching documents but don't contribute to scoring
      minimum_should_match: minimum should match as interger or percentage
=end

    def initialize
      @should_queries = []
      @must_queries = []
      @mustnot_queries = []
      @filter_queries = []
      @minimum_should_match = nil
    end

    def query
      query = {}
      bool_query = self.common_query
      bool_query[:should] = @should_queries.map{|query_ob| query_ob.query} if @should_queries.present?
      bool_query[:must] = @must_queries.map{|query_ob| query_ob.query} if @must_queries.present?
      bool_query[:must_not] = @mustnot_queries.map{|query_ob| query_ob.query} if @mustnot_queries.present?
      bool_query[:filter] = @filter_queries.map{|query_ob| query_ob.query} if @filter_queries.present?
      bool_query[:minimum_should_match] = @minimum_should_match if @minimum_should_match.present?
      bool_query[:boost] = @boost if @boost.present?
      query[name.intern] = bool_query
      return query
    end

  ########## FILTER QUERIES ##########
  # gets the filter queries
    def filter_expr
      return @filter_queries
    end
  # adds a filter query
    def filter query_builder
      query_builder.is_a?(array) ? @filter_queries += query_builder : @filter_queries.append(query_builder)
      return self
    end


  ########## SHOULD QUERIES ##########
  # gets the should queries
    def should_expr
      return @should_queries
    end
  # adds a should query
    def should query_builder
      query_builder.is_a?(Array) ? @should_queries += query_builder : @should_queries.append(query_builder)
      return self
    end


  ########## MUST QUERIES ##########
  # gets the must queries
    def must_expr
      return @must_queries
    end
  # adds a must query
    def must query_builder
      query_builder.is_a?(Array) ? @must_queries += query_builder : @must_queries.append(query_builder)
      return self
    end


  ########## MUSTNOT QUERIES ##########
  # gets the mustnot queries
    def must_not_expr
      return @mustnot_queries
    end
  # adds a mustnot query
    def must_not query_builder
      query_builder.is_a?(Array) ? @mustnot_queries += query_builder : @mustnot_queries.append(query_builder)
      return self
    end


  ########## MINIMUM SHOULD MATCH VALUE ##########
  # gets the minimumShouldMatch value
    def minimum_should_match_expr
      return @minimum_should_match
    end
  # sets the minimumShouldMatch value
    def minimum_should_match value
      raise "Minimum Should match cannot be nil" if value.nil?
      @minimum_should_match = value
      return self
    end


  ########## HAS CLAUSES ##########
  # returns true iff this query builder has at least one should, must, must not or filter clause
    def has_clauses?
      return !(@should_queries.nil? && @must_queries.nil? && @mustnot_queries.nil? && @filter_queries.nil?)
    end

  end
end