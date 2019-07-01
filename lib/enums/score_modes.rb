# frozen_string_literal: true

module Enums
  # Enumerator class for how results of individual
  # score functions will be aggregated
  class ScoreModes
    # @!visibility protected
    SCORE_MODES = { multiply: 'multiply', sum: 'sum', avg: 'avg',
                    first: 'first', max: 'max', min: 'min' }.freeze
    # @!visibility protected
    attr_reader :score_mode
    # @!visibility protected
    SCORE_MODES.each do |sc_md, es_value|
      define_singleton_method(sc_md) do
        return new(es_value)
      end
    end

    # @!scope class
    # @!method multiply
    # @return [ScoreModes] ScoreModes object
    #   corresponding to elasticsearch option of 'multiply'

    # @!scope class
    # @!method sum
    # @return [ScoreModes] ScoreModes object
    #   corresponding to elasticsearch option of 'sum'

    # @!scope class
    # @!method avg
    # @return [ScoreModes] ScoreModes object
    #   corresponding to elasticsearch option of 'avg'

    # @!scope class
    # @!method first
    # @return [ScoreModes] ScoreModes object
    #   corresponding to elasticsearch option of 'first'

    # @!scope class
    # @!method max
    # @return [ScoreModes] ScoreModes object
    #   corresponding to elasticsearch option of 'max'

    # @!scope class
    # @!method min
    # @return [ScoreModes] ScoreModes object
    #   corresponding to elasticsearch option of 'min'

    # @!visibility protected
    def initialize(score_mode)
      @score_mode = score_mode
    end
  end
end
