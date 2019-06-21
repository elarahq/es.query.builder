class ConstantScoreQueryBuilder < QueryBuilder

  NAME = "constant_score"

  attr_reader :inner_query

=begin
  A query that wraps a filter and simply returns a constant score equal to the query boost for every document in the filter.
=end
  def initialize inner_query
    raise "Not A Query Object" unless inner_query.methods.include?(:query)
    @inner_query = inner_query
  end

  def query
    query = {}
    cs_query = self.common_query
    cs_query.merge!(@inner_query.query) if @inner_query.present?
    query[name.intern] = cs_query
    return query
  end

end
