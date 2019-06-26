class SortModes

  SORT_MODES = {min: 'min', max: 'max', sum: 'sum', avg: 'avg', median: 'median'}

  attr_reader :sort_mode

  SORT_MODES.each do |sort_mode, es_value|
    define_singleton_method(sort_mode) do
      return self.new(es_value)
    end
  end

  def initialize sort_mode
    @sort_mode = sort_mode
  end

end