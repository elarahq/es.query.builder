# A query that wraps a filter and simply returns a constant score equal to the query boost for every document in the filter.
require_relative 'query_builder'
class ConstantScoreQueryBuilder < QueryBuilder

  NAME = "constant_score"

=begin
  @params:
    inner_query: query for whose matching documents constant score is to be set.
    boost: boosting value
=end
  def initialize inner_query:
    @inner_query = inner_query
  end

  def query
    query = {}
    cs_query = self.common_query
    cs_query.merge!(@inner_query.query) if @inner_query.present?
    query[name.intern] = cs_query
    return query
  end

# Returns inner_query
  def inner_query_expr
    return @inner_query
  end

end
