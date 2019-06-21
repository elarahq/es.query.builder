class CombineFunctions

  COMBINE_FUNCTIONS = {multiply: 'multiply', replace: 'replace', sum: 'sum', avg: 'avg', max: 'max', in: 'min'}

  attr_reader :combine_function

  COMBINE_FUNCTIONS.keys.each do |fnctn|
    define_singleton_method(fnctn) do
      return self.new(COMBINE_FUNCTIONS[fnctn])
    end
  end

  def initialize value
    @combine_function = value
  end

end