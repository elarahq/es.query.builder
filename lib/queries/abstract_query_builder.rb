module AbstractQueryBuilder

  def doEquals​? query
    # Checks if given query object is same as this query object
    return self.query == query.query
  end

  def common_query
    common_query = {}
    common_query[:boost] = @boost if @boost.present?
    return common_query
  end

  def name
    self.class::NAME.to_s
  end

  def wrap_query
    query = {query: self.query}
    return query
  end

end
