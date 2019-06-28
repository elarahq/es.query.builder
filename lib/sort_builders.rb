class SortBuilders

  def self.field_sort *args
    return Sort::FieldSortBuilder.new(*args)
  end

  def self.geo_distance_sort *args
    return Sort::GeoDistanceSortBuilder.new(*args)
  end

  def self.nested_sort *args
    return Sort::NestedSortBuilder.new(*args)
  end

  def self.score_sort
    return Sort::ScoreSortBuilder.new
  end

  def self.script_sort *args
    return Sort::ScriptSortBuilder.new(*args)
  end

end
