module AbstractRangeHelper


  def abstract_range_builder
    builder = {}
    builder[:ranges] = @ranges if @ranges.present?
    builder[:keyed] = @keyed if @keyed.present?
    builder
  end

  def add_range from, to, key=''
    @ranges ||= []
    range = {}
    range[:key] = key if key.present?
    range[:from] = from if from.present?
    range[:to] = to if to.present?
    @ranges << range if range.present?
    self
  end

  def get_ranges
    @ranges
  end

  def keyed keyed
    @keyed = keyed
    self
  end

  def get_keyed
    @keyed
  end

end