class AggregationBuilders

  def self.terms name
    return ::Aggregations::Buckets::TermsAggregationBuilder.new(name)
  end

  def self.filter name, filter
    return ::Aggregations::Buckets::FilterAggregationBuilder.new(name: name,
                                                                 filter: filter)
  end

  def self.geohash_grid name
    return ::Aggregations::Buckets::GeoGridAggregationBuilder.new(name)
  end

  def self.top_hits name
    return ::Aggregations::Buckets::TopHitsAggregationBuilder.new(name)
  end

  def self.nested name, path
    return ::Aggregations::Buckets::NestedAggregationBuilder.new(name: name,
                                                                 path: path)
  end

  def self.reverse_nested name
    return ::Aggregations::Buckets::ReverseNestedAggregationBuilder.new(name)
  end

  def self.date_histogram name
    return ::Aggregations::Buckets::DateHistogramAggregationBuilder.new(name)
  end

  def self.histogram name
    return ::Aggregations::Buckets::HistogramAggregationBuilder.new(name)
  end

  def self.date_range name
    return ::Aggregations::Buckets::DateRangeAggregationBuilder.new(name)
  end

  def self.range name
    return ::Aggregations::Buckets::RangeAggregationBuilder.new(name)
  end

  def self.max name
    return ::Aggregations::Metrics::MaxAggregationBuilder.new(name)
  end

end