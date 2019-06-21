class QueryBuilder
  include AbstractQueryBuilder

  # attr_accessor :boost

  NAME = 'base'

=begin
  Returns the boost for this query
=end
  def boost_expr
    return @boost
  end

=begin
  Sets the boost for this query
=end
  def boost value
    raise "boost value is nil" if value.nil?
    @boost = value
    return self
  end

end