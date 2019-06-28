# Filters documents that include only hits that exists within a specific distance from a geo point. 
require_relative 'query_builder'
module Queries
  class GeoDistanceQueryBuilder < QueryBuilder

    NAME = 'geo_distance'
    DEFAULT_DISTANCE_UNIT = ::Enums::DistanceUnits.meters

=begin
    @params:
      field_name: geo_point field in the document which is matched with the given query
      point: center point for this query
      distance: The radius of the circle centred on the specified location. Points which fall into this circle are considered to be matches.
      distance_unit: The distance can be specified in various units. See Distance Units.
      distance_type: How to compute the distance. Can either be arc (default),
                     or plane (faster, but inaccurate on long distances and close to the poles)
      writable_name: Optional name field to identify the query
      validation_method: Set to IGNORE_MALFORMED to accept geo points with invalid latitude or longitude,
                         set to COERCE to additionally try and infer correct coordinates (default is STRICT).
      ignore_unmapped: When set to true the ignore_unmapped option will ignore an unmapped field and will not match any documents for this query.
                       When set to false (the default value) the query will throw an exception if the field is not mapped.
=end

    def initialize field_name:
      @field_name = field_name
      @point = nil
      @distance = nil
      @distance_unit = DEFAULT_DISTANCE_UNIT.distance_unit
      @distance_type = nil
      @writable_name = nil
      @validation_method = nil
      @ignore_unmapped = nil
    end

    def query
      query = {}
      geo_query = self.common_query
      geo_query[:field_name] = point.settings
      geo_query[:distance] = @distance.to_s + @distance_unit.to_s
      geo_query[:distance_type] = @distance_type
      geo_query[:writable_name] = @writable_name
      geo_query[:validation_method] = @validation_method
      geo_query[:ignore_unmapped] = @ignore_unmapped
      query[name.intern] = geo_query
      return query
    end

  # Returns point
    def point_expr
      return @point
    end

  # Sets point
    def point point
      @point = point
    end

  # Returns field_name
    def field_name_expr
      returns @field_name
    end

  # Returns distance
    def distance_expr
      return @distance
    end

  # Returns distance_unit
    def distance_unit_expr
      return @distance_unit
    end

  # Sets distance and distance_unit
    def distance distance, distance_unit= nil
      @distance = distance
      @distance_unit = distance_unit.distance_unit if @distance_unit.present?
      return self
    end

  # Returns distance_type
    def distance_type_expr
      return @distance_type
    end

  # Sets distance_type
    def distance_type distance_type
      @distance_type = distance_type.distance_type
      return self
    end

  # Returns writable_name
    def writable_name_expr
      return @writable_name
    end

  # Sets writable_name
    def writable_name writable_name
      @writable_name = writable_name
      return self
    end

  # Returns validation_method
    def validation_method_expr
      return @validation_method
    end

  # Sets validation_method
    def validation_method validation_method
      @validation_method = validation_method.validation_method
      return self
    end

  # Returns ignore_unmapped
    def ignore_unmapped_expr
      return @ignore_unmapped
    end

  # Sets ignore_unmapped
    def ignore_unmapped ignore_unmapped
      @ignore_unmapped = ignore_unmapped
      return self
    end

  end
end