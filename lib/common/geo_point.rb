class GeoPoint

  attr_reader :lat, :lng, :latlng, :geo_hash

  def initialize lat= nil, lng= nil, latlng= nil, geo_hash= nil
    if lat.present? and lng.present?
      @lat= lat.to_f
      @lng= lng.to_f
      @type = :float
    elsif latlng.present?
      @latlng= latlng
      @type = latlng.class.name.downcase.intern
    elsif geo_hash.present?
      @geo_hash= geo_hash
      @type = :geohash
    else
      raise "Provide Point as floating values latitude and longitude or a string or an array or a geohash"
    end
  end

  def settings
    case @type
    when :float
      return {lat: @lat, lon: @lng}
    when :array || :string
      return @latlng
    when :geohash
      return @geohash
    end
  end
end
