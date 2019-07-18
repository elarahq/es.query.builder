# frozen_string_literal: true

module Misc
  # A bucket associated with a specific range
  class Range
    include AttributesReader

    # @param [String|Float] from
    # @param [String|Float] to
    # @param [String] key
    def initialize(from: nil, to: nil, key: '')
      @from = from if from.present?
      @to = to if to.present?
      @key = key if key.present?
    end

    # return [Hash] serialized json query for object
    def settings
      settings = {}
      settings[:key] = key if key.present?
      settings[:from] = from if from.present?
      settings[:to] = to if to.present?
      settings
    end

    # @return [String|Float]
    # @!visibility protected
    def from_expr
      @from
    end

    # @return [String|Float]
    # @!visibility protected
    def to_expr
      @to
    end

    # @return [String]
    # @!visibility protected
    def key_expr
      @key
    end
  end
end
