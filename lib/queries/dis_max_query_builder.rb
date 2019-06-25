=begin 
  A query that generates the union of documents produced by its sub-queries, and that scores each document
  with the maximum score for that document as produced by any sub-query, plus a tie breaking increment for any additional matching sub-queries.
=end
require_relative 'query_builder'
class DisMaxQueryBuilder < QueryBuilder

  DEFAULT_TIE_BREAKER = 0.0
  NAME = "dis_max"

=begin
  @params:
    queries: sub-queries of this disjunction query
    tie_breaker: the score of each non-maximum disjunct for a document is multiplied by this weight and added into the final score. 
                 If non-zero, the value should be small, on the order of 0.1, which says that 10 occurrences of word in a lower-scored field 
                 that is also in a higher scored field is just as good as a unique word in the lower scored field 
                 (i.e., one that is not in any higher scored field).
=end

  def initialize
    @queries = []
    @tie_breaker = DEFAULT_TIE_BREAKER
  end

  def query
    query = {}
    dm_query = self.common_query
    dm_query[:queries] = @queries.map{|query| query.query} if @queries.present?
    dm_query[:tie_breaker] = @tie_breaker
    query[name.intern] = dm_query
    return query
  end

########## INNER QUERIES ##########
# an immutable list copy of the current sub-queries of this disjunction
  def inner_queries
    return @queries
  end

########## TIE BREAKER ##########
# returns the tie breaker value
  def tie_breaker_expr
    return @tie_breaker
  end
# adds the tie breaker value
  def tie_breaker value
    raise "Tie Breaker value is nil" if value.nil?
    @tie_breaker = value
    return self
  end

########## SUB QUERIES ##########
# add a sub-query to this disjunction
  def add query
    raise "Query for Dismax is nil" if query.nil?
    @queries.append(query)
    return self
  end

end