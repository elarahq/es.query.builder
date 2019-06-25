# Factory class for common classes
class CommonBuilders

  def self.geo_point *args
    return GeoPoint.new *args
  end

  def self.terms_lookup *args
    return TermsLookup.new *args
  end

end