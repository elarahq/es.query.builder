# Wraps a query keyword around the query of the given object
require_relative 'query_builder'
class BaseQueryBuilder < QueryBuilder

  NAME = 'query'

=begin
  @params:
    inner_query: query object whose query is to be wrapped around query keyword
=end
  
  def initialize inner_query:
    @inner_query = inner_query
  end

  def query
    query = {name.intern=> inner_query.query}
    return query
  end

# Returns inner_query
  def inner_query_expr
    return @inner_query
  end

end