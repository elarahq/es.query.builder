class DistanceUnits

  DISTANCE_UNITS = {miles: 'mi', yards: 'yd', feet: 'ft', inch: 'in', kilometers: 'km', meters: 'm', centimeters: 'cm', millimeters: 'mm', nauticalmiles: 'nmi'}

  attr_reader :distance_unit

  DISTANCE_UNITS.each do |du, es_value|
    define_singleton_method(du) do
      self.new(es_value)
    end
  end

  def initialize distance_unit
    @distance_unit = distance_unit
  end

end

