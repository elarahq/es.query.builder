# frozen_string_literal: true

module Enums
  # Enumerator class for type of measurement of geo distance.
  class DistanceTypes
    # @!visibility protected
    DISTANCE_TYPES = { arc: 'arc', plane: 'plane' }.freeze

    # @!visibility protected
    attr_reader :distance_type

    # @!visibility protected
    DISTANCE_TYPES.each do |distn_type, es_value|
      define_singleton_method(distn_type) do
        return new(es_value)
      end
    end

    # @!scope class
    # @!method arc
    # default type
    # @return [DistanceTypes] DistanceTypes object
    #   corresponding to elasticsearch option of 'arc'

    # @!scope class
    # @!method plane
    # faster, but inaccurate on long distances and close to the poles
    # @return [DistanceTypes] DistanceTypes object
    #   corresponding to elasticsearch option of 'plane'

    # @!visibility protected
    def initialize(distn_type)
      @distance_type = distn_type
    end
  end
end
