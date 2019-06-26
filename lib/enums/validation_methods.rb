class ValidationMethods

  VALIDATION_METHODS = {coerce: 'COERCE', ignore_malformed: 'IGNORE_MALFORMED', strict: 'STRICT'}

  attr_reader :validation_method

  VALIDATION_METHODS.keys.each do |validation_method|
    define_singleton_method(validation_method) do
      self.new(VALIDATION_METHODS[validation_method])
    end
  end

  def initialize validation_method
    @validation_method = validation_method
  end

end