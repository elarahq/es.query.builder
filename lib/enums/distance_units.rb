class DistanceUnits

  DISTANCE_UNITS = {miles: 'mi', yards: 'yd', feet: 'ft', inch: 'in', kilometers: 'km', meters: 'm', centimeters: 'cm', millimeters: 'mm', nauticalmiles: 'nmi'}

  attr_reader :distance_unit

  DISTANCE_UNITS.keys.each do |du|
    define_singleton_method(du) do
      self.new(DISTANCE_UNITS[du])
    end
  end

  def initialize distance_unit
    @distance_unit = distance_unit
  end

end

