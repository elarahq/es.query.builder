class GeoValidationMethods

  GEO_VALIDATION_METHODS = {coerce: 'COERCE', ignore_malformed: 'IGNORE_MALFORMED', strict: 'STRICT'}

  attr_reader :geo_validation_method

  GEO_VALIDATION_METHODS.keys.each do |validation_method|
    define_singleton_method(validation_method) do
      self.new(GEO_VALIDATION_METHODS[validation_method])
    end
  end

  def initialize validation_method
    @geo_validation_method = validation_method
  end

end