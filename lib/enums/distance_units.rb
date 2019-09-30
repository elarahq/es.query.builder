# frozen_string_literal: true

module Enums
  # Enumerator class for diatnce units.
  class DistanceUnits
    # @!visibility protected
    DISTANCE_UNITS = { miles: 'mi', yards: 'yd', feet: 'ft', inches: 'in',
                       kilometers: 'km', meters: 'm', centimeters: 'cm',
                       millimeters: 'mm', nauticalmiles: 'nmi' }.freeze

    # @!visibility protected
    attr_reader :distance_unit

    # @!visibility protected
    DISTANCE_UNITS.each do |du, es_value|
      define_singleton_method(du) do
        new(es_value)
      end
    end

    # @!scope class
    # @!method miles
    # @return [DistanceUnits] DistanceUnits object
    #   corresponding to elasticsearch option of 'mi'

    # @!scope class
    # @!method yards
    # @return [DistanceUnits] DistanceUnits object
    #   corresponding to elasticsearch option of 'yd'

    # @!scope class
    # @!method feet
    # @return [DistanceUnits] DistanceUnits object
    #   corresponding to elasticsearch option of 'ft'

    # @!scope class
    # @!method inches
    # @return [DistanceUnits] DistanceUnits object
    #   corresponding to elasticsearch option of 'in'

    # @!scope class
    # @!method kilometers
    # @return [DistanceUnits] DistanceUnits object
    #   corresponding to elasticsearch option of 'kme'

    # @!scope class
    # @!method meters
    # @return [DistanceUnits] DistanceUnits object
    #   corresponding to elasticsearch option of 'm'

    # @!scope class
    # @!method centimeters
    # @return [DistanceUnits] DistanceUnits object
    #   corresponding to elasticsearch option of 'cm'

    # @!scope class
    # @!method millimeters
    # @return [DistanceUnits] DistanceUnits object
    #   corresponding to elasticsearch option of 'mm'

    # @!scope class
    # @!method nauticalmiles
    # @return [DistanceUnits] DistanceUnits object
    #   corresponding to elasticsearch option of 'nmi'

    # @!visibility protected
    def initialize(distance_unit)
      @distance_unit = distance_unit
    end
  end
end
