require_relative 'abstract_query_builder'
require_relative '../attributes_reader'
class QueryBuilder
  include AbstractQueryBuilder
  include AttributesReader

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