module Misc
  class GeoPoint
    include AttributesReader

    def initialize lat: nil, lng: nil, latlng: nil, geo_hash: nil
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

    def lat_expr
      return @lat
    end

    def lng_expr
      return @lng
    end

    def latlng_expr
      return @latlng
    end

    def geo_hash_expr
      return @geo_hash
    end

  end
end
