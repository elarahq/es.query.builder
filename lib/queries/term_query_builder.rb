=begin
  Returns documents that contain an exact term in a provided field.
  You can use the term query to find documents based on a precise value such as a price, a product ID, or a username.
=end
class TermQueryBuilder < QueryBuilder

  NAME = "term"

  attr_reader :field_name, :value

# @params: field_name is name of the field in the document which is being queried, and value is being matched to the data in that field.
  def initialize field_name, value
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

end
