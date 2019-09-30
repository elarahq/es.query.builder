# frozen_string_literal: true

module Misc
  # Point Class
  class GeoPoint
    include AttributesReader

    # @params [Numeric] lat latitude
    # @params [Numeric] lng longitude
    # @params [Array|String] latlng
    #   latitude and longitude as array or string
    #   Format in [lon, lat] when array, such as [-70,40]
    #   Format in lat,lon when string, such as '40,-70'
    # @params [String] geohash point geohash
    def initialize(lat: nil, lng: nil, latlng: nil, geo_hash: nil)
      if lat.present? && lng.present?
        @lat = lat.to_f
        @lng = lng.to_f
        @type = :float
      elsif latlng.present?
        @latlng = latlng
        @type = latlng.class.name.downcase.intern
      elsif geo_hash.present?
        @geo_hash = geo_hash
        @type = :geohash
      else
        raise 'Provide Point as floating values latitude and longitude
               or a string or an array or a geohash'
      end
    end

    # @return [Hash] serialized json query for object
    def settings
      case @type
      when :float
        { lat: @lat, lon: @lng }
      when :array || :string
        @latlng
      when :geohash
        @geohash
      end
    end

    # @!visibility protected
    def lat_expr
      @lat
    end

    # @!visibility protected
    def lng_expr
      @lng
    end

    # @!visibility protected
    def latlng_expr
      @latlng
    end

    # @!visibility protected
    def geo_hash_expr
      @geo_hash
    end
  end
end
