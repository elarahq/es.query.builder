class AggregationBuilders

  def self.terms name
    return TermsAggregationBuilder.new(name)
  end

  def self.filter name, filter
    return FilterAggregationBuilder.new(name, filter)
  end

  def self.terms name
    return TermsAggregationBuilder.new(name)
  end

  def self.geohash_grid name
    return GeoGridAggregationBuilder.new(name)
  end

  def self.top_hits name
    return TopHitsAggregationBuilder.new(name)
  end

  def self.nested name, path
    return NestedAggregationBuilder.new(name, path)
  end

  def self.reverse_nested name
    return ReverseNestedAggregationBuilder.new(name)
  end

  def self.date_histogram name
    return DateHistogramAggregationBuilder.new(name)
  end

  def self.histogram name
    return HistogramAggregationBuilder.new(name)
  end

  def self.date_range name
    return DateRangeAggregationBuilder.new(name)
  end

  def self.range name
    return RangeAggregationBuilder.new(name)
  end

  def self.max name
    return MaxAggregationBuilder.new(name)
  end

end