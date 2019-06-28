 module Enums 
  class ShapeRelations

    WITHIN = 'within'
    CONTAINS = 'contains'
    INTERSECTS = 'intersects'

    attr_reader :relation

    def self.within
      return self.new(WITHIN)
    end

    def self.contains
      return self.new(CONTAINS)
    end

    def self.intersects
      return self.new(INTERSECTS)
    end

    def initialize value
      @relation = value
    end

  end
end