# frozen_string_literal: true

module Enums
  # A unit class that encapsulates all in-exact search parsing and
  # conversion from similarities to edit distances etc.
  class Fuzziness
    # @!visibility protected
    AUTO = 'AUTO'
    # @!visibility protected
    ZERO = 0
    # @!visibility protected
    ONE = 1
    # @!visibility protected
    TWO = 2
    # @!visibility protected
    attr_reader :fuzziness

    # @return [Fuzziness] returns Fuzziness object corresponding to
    #   exact match
    def self.zero
      new(ZERO)
    end

    # @return [Fuzziness] returns a fuzziness object with
    #   maximum levenshtein distance as one.
    def self.one
      new(ONE)
    end

    # @return [Fuzziness] returns a fuzziness object with
    #   maximum levenshtein distance as two.
    def self.two
      new(TWO)
    end

    # Returns a fuzziness object with maximum levenshtein distance in auto mode.
    #   Generates an edit distance based on the length of the term.
    #   Low and high distance arguments may be optionally provided
    #   AUTO:[low],[high]. If not specified, the default values are 3 and 6,
    #   equivalent to AUTO:3,6 that make for lengths:
    #     0..2
    #       Must match exactly
    #     3..5
    #       One edit allowed
    #     >5
    #       Two edits allowed
    #   AUTO should generally be the preferred value for fuzziness.
    def self.auto(low = nil, high = nil)
      new("#{AUTO}:#{low},#{high}")
    end
    # @!visibility protected
    def initialize(fuzziness_value)
      @fuzziness = fuzziness_value
    end
  end
end
