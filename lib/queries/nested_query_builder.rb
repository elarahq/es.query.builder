=begin
  Nested query allows to query nested objects / docs (see nested mapping). The query is executed against the nested objects / docs 
  as if they were indexed as separate docs (they are, internally) and resulting in the root parent doc (or parent nested mapping).
=end
class NestedQueryBuilder < QueryBuilder

  NAME = "nested"

  attr_reader :path, :inner_query, :score_mode

=begin
  @params:
    path: The query path points to the nested object path.
    score_mode: The score_mode allows to set how inner children matching affects scoring of parent.
                It defaults to avg, but can be sum, min, max and none.
    inner_query: query includes the query that will run on the nested docs matching the direct path, and joining with the root parent docs

  Any fields referenced inside the query must use the complete path (fully qualified)
=end
  def initialize path, inner_query, score_mode
    @path = path
    @inner_query = query
    @score_mode = score_mode.score_mode
  end

  def query
    query = {}
    nested_query = self.common_query
    nested_query[:path] = @path if @path.present?
    nested_query[:query] = @inner_query.query if @inner_query.present?
    nested_query[:score_mode] = @score_mode if @score_mode.present?
    query[name.intern] = nested_query
    return query
  end

end