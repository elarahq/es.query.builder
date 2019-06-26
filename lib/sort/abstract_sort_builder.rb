module AbstractSortBuilder

  def doEquals​? sort
    # Checks if given sort object is same as this sort object
    return self.query == sort.query
  end

  def name
    self.class::NAME.to_s
  end

end

