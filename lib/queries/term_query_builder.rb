=begin
  Returns documents that contain an exact term in a provided field.
  You can use the term query to find documents based on a precise value such as a price, a product ID, or a username.
=end
require_relative 'query_builder'
class TermQueryBuilder < QueryBuilder

  NAME = "term"

=begin
  @params: 
    field_name: name of the field in the document which is being queried
    value: is being matched to the data in that field.
=end
  def initialize field_name:, value: nil
    @field_name = field_name
    @value = value
  end

  def query
    query = {}
    term_query = {}
    field_options = self.common_query
    field_options[:value] = @value
    term_query[@field_name.intern] = field_options
    query[name.intern] = term_query
    return query
  end

########## FIELD NAME ##########
# returns field_name
  def field_name_expr
    return @field_name
  end

########## FIELD VALUE ##########
# returns value
  def value_expr
    return @value
  end

end
