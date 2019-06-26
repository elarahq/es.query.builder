# A sort builder allowing to sort by score.
require_relative 'sort_builder'
class ScoreSortBuilder < SortBuilder

  NAME = '_score'

  def query
    query = {}
    score_query = self.common_query
    query[name.intern] = score_query
    return query
  end

end