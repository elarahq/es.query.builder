module AbstractAggregationHelper


  def abstract_agg_builder
    builder = {}
    builder[:aggs] = @sub_aggregation if @sub_aggregation.present?
    builder
  end

  def sub_aggregation sub_agg
    @sub_aggregation = sub_agg.get_query
    self
  end

  def get_sub_aggregation
    @sub_aggregation
  end

end