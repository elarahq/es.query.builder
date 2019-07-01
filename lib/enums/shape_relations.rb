# frozen_string_literal: true

module Enums
  # Enum class representing the relationship
  # between a Query / Filter Shape
  # and indexed Shapes that will be used to determine
  # if a Document should be matched or not
  class ShapeRelations
    # @!visibility protected
    WITHIN = 'within'
    # @!visibility protected
    CONTAINS = 'contains'
    # @!visibility protected
    INTERSECTS = 'intersects'
    # @!visibility protected
    attr_reader :relation

    # @!scope class
    # @!method number
    # @return [ShapeRelations] ShapeRelations object
    #   corresponding to elasticsearch option of 'within'
    def self.within
      new(WITHIN)
    end

    # @!scope class
    # @!method number
    # @return [ShapeRelations] ShapeRelations object
    #   corresponding to elasticsearch option of 'contains'
    def self.contains
      new(CONTAINS)
    end

    # @!scope class
    # @!method number
    # @return [ShapeRelations] ShapeRelations object
    #   corresponding to elasticsearch option of 'intersects'
    def self.intersects
      new(INTERSECTS)
    end

    # @!visibility protected
    def initialize(value)
      @relation = value
    end
  end
end
