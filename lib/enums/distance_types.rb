module Enums
  class DistanceTypes

    DISTANCE_TYPES = {arc: 'arc', plane: 'plane'}

    attr_reader :distance_type

    DISTANCE_TYPES.each do |distn_type, es_value|
      define_singleton_method(distn_type) do
        return self.new(es_value)
      end
    end

    def initialize distn_type
      @distance_type = distn_type
    end

  end
end