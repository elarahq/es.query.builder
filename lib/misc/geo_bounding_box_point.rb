# frozen_string_literal: true

module Misc
  # Point Class
  class GeoBoundingBoxPoint
    include AttributesReader

    # @params [Numeric] lat latitude
    # @params [Numeric] lng longitude
    # @params [Array|String] latlng
    #   latitude and longitude as array or string
    #   Format in [lon, lat] when array, such as [-70,40]
    #   Format in lat,lon when string, such as '40,-70'
    # @params [String] geohash point geohash
    def initialize(lat: nil, lng: nil, radius: nil, latlng: nil, geo_hash: nil)
      if lat.present? && lng.present?
        @lat = lat.to_f
        @lng = lng.to_f
        @radius = radius.to_f
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
        get_bounding_box_point
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

    def get_coordinates
      radius_of_earth = 6378.1
      pi = 3.14159
      deg_to_rad =  pi/180
      lat_in_rad = @lat * deg_to_rad
      lon_in_rad = @lon * deg_to_rad
      delta_rad = @radius/radius_of_earth
      ne_coordinates = {
          latitude: (lat_in_rad + delta_rad)/ deg_to_rad,
          longitude: (lon_in_rad + delta_rad)/ deg_to_rad
      }
      sw_coordinates = {
          latitude: (lat_in_rad - delta_rad)/ deg_to_rad,
          longitude: (lon_in_rad - delta_rad)/ deg_to_rad
      }
      nw_coordinates = {
          latitude: (lat_in_rad - delta_rad)/ deg_to_rad,
          longitude: (lon_in_rad + delta_rad)/ deg_to_rad
      }
      se_coordinates = {
          latitude: (lat_in_rad + delta_rad)/ deg_to_rad,
          longitude: (lon_in_rad - delta_rad)/ deg_to_rad
      }
      {ne_coordinates: ne_coordinates, sw_coordinates: sw_coordinates, nw_coordinates: nw_coordinates, se_coordinates: se_coordinates}
    end

    def get_bounding_box_point
      direction_coordinates = get_coordinates
      ne_lat_lng, sw_lat_lng =  direction_coordinates[:ne_coordinates], direction_coordinates[:sw_coordinates]
      {
        top_right: {lat: ne_lat_lng[:latitude].to_f,
                   lon: ne_lat_lng[:longitude].to_f},
        bottom_left: {lat: sw_lat_lng[:latitude].to_f,
                     lon: sw_lat_lng[:longitude].to_f}
      }
    end

  end
end

