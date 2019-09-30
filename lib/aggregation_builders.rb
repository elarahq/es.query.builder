class AggregationBuilders

  def self.terms(*args)
    return ::Aggregations::Buckets::TermsAggregationBuilder.new(*args)
  end

  def self.filter(*args)
    return ::Aggregations::Buckets::FilterAggregationBuilder.new(*args)
  end

  def self.filters(*args)
    return ::Aggregations::Buckets::FiltersAggregationBuilder.new(*args)
  end

  def self.geohash_grid(*args)
    return ::Aggregations::Buckets::GeoGridAggregationBuilder.new(*args)
  end

  def self.top_hits(*args)
    return ::Aggregations::Buckets::TopHitsAggregationBuilder.new(*args)
  end

  def self.nested(*args)
    return ::Aggregations::Buckets::NestedAggregationBuilder.new(*args)
  end

  def self.reverse_nested(*args)
    return ::Aggregations::Buckets::ReverseNestedAggregationBuilder.new(*args)
  end

  def self.date_histogram(*args)
    return ::Aggregations::Buckets::DateHistogramAggregationBuilder.new(*args)
  end

  def self.histogram(*args)
    return ::Aggregations::Buckets::HistogramAggregationBuilder.new(*args)
  end

  def self.date_range(*args)
    return ::Aggregations::Buckets::DateRangeAggregationBuilder.new(*args)
  end

  def self.range(*args)
    return ::Aggregations::Buckets::RangeAggregationBuilder.new(*args)
  end

  def self.max(*args)
    return ::Aggregations::Metrics::MaxAggregationBuilder.new(*args)
  end

  def self.min(*args)
    return ::Aggregations::Metrics::MinAggregationBuilder.new(*args)
  end

  def self.avg(*args)
    return ::Aggregations::Metrics::AvgAggregationBuilder.new(*args)
  end

end