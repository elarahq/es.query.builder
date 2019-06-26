class CombineFunctions

  COMBINE_FUNCTIONS = {multiply: 'multiply', replace: 'replace', sum: 'sum', avg: 'avg', max: 'max', in: 'min'}

  attr_reader :combine_function

  COMBINE_FUNCTIONS.each do |comb_fnctn, es_value|
    define_singleton_method(comb_fnctn) do
      return self.new(es_value)
    end
  end

  def initialize combine_function
    @combine_function = combine_function
  end

end