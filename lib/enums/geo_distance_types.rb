class GeoDistanceTypes

  GEO_DISTANCE_TYPES = {arc: 'arc', plane: 'plane'}

  attr_reader :geo_distance_type

  GEO_DISTANCE_TYPES.keys.each do |distn_type|
    define_singleton_method(distn_type) do
      return self.new(GEO_DISTANCE_TYPES[distn_type])
    end
  end

  def initialize distn_type
    @geo_distance_type = distn_type
  end

end