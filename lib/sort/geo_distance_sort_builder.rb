# A geo distance based sorting on a geo point like field.
require_relative 'sort_builder'
module Sort
  class GeoDistanceSortBuilder < SortBuilder

    NAME = '_geo_distance'

=begin
    @params:
      field_name: The geo point like field the distance based sort operates on.
      distance_type: How to compute the distance. Can either be arc (default), 
                     or plane (faster, but inaccurate on long distances and close to the poles).
      distance_unit: The unit to use when computing sort values. The default is m (meters).
      nested_sort: Nested path within current object.
      ignore_unmapped: Indicates if the unmapped field should be treated as a missing value. 
                       Setting it to true is equivalent to specifying an unmapped_type in the field sort. The default is false (unmapped field cause the search to fail).
      point: The point to create the range distance facets from.
      sort_mode: What to do in case a field has several geo points. By default, the shortest distance is taken into account when sorting 
                 in ascending orderand the longest distance when sorting in descending order. Supported values are min, max, median and avg.
      validation_method: Set to IGNORE_MALFORMED to accept geo points with invalid latitude or longitude,
                         set to COERCE to additionally try and infer correct coordinates (default is STRICT).
=end
    
    def initialize field_name:, point:
      @field_name = field_name
      @point = point
      @distance_type = nil
      @distance_unit = nil
      @nested_sort = nil
      @ignore_unmapped = nil
      @sort_mode = nil
      @validation_method = nil
    end

    def query
      query = {}
      go_query = self.common_query
      go_query["#{@field_name}.location".intern] = @point.settings
      go_query[:distance_type] = @distance_type if @distance_type.present?
      go_query[:unit] = @distance_unit if @distance_unit.present?
      go_query[:nested] = @nested_sort.query if @nested_sort.present?
      go_query[:ignore_unmapped] = @ignore_unmapped if @ignore_unmapped.present?
      go_query[:sort_mode] = @sort_mode if @sort_mode.present?
      go_query[:validation_method] = @validation_method if @validation_method.present?
      query[name.intern] = go_query
      return query
    end

  # returns field_name
    def field_name_expr
      return @field_name
    end

  # returns point
    def point_expr
      return @point
    end
  # sets point
    def point point
      @point = point
      return self
    end

  # returns distance_type
    def distance_type_expr
      return @distance_type
    end
  # sets distance_type
    def distance_type distance_type
      @distance_type = distance_type.distance_type
      return self
    end

  # returns distance_unit
    def distance_unit_expr
      return @distance_unit
    end
  # sets distance_unit
    def distance_unit distance_unit
      @distance_unit = distance_unit.distance_unit
      return self
    end

  # returns nested_sort
    def nested_sort_expr
      return @nested_sort
    end
  # sets nested_sort
    def nested_sort nested_sort
      @nested_sort = nested_sort
      return self
    end

  # returns ignore_unmapped
    def ignore_unmapped_expr
      return @ignore_unmapped
    end
  # sets ignore_unmapped
    def ignore_unmapped ignore_unmapped
      @ignore_unmapped = ignore_unmapped
      return self
    end

  # returns sort_mode
    def sort_mode_expr
      return @sort_mode
    end
  # sets sort_mode
    def sort_mode sort_mode
      @sort_mode = sort_mode.sort_mode
      return self
    end

    def validation_method validation_method
      @validation_method = validation_method.validation_method
      return self
    end

  end
end