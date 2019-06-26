class ValidationMethods

  VALIDATION_METHODS = {coerce: 'COERCE', ignore_malformed: 'IGNORE_MALFORMED', strict: 'STRICT'}

  attr_reader :validation_method

  VALIDATION_METHODS.each do |validation_method, es_value|
    define_singleton_method(validation_method) do
      self.new(es_value)
    end
  end

  def initialize validation_method
    @validation_method = validation_method
  end

end