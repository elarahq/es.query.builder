module Enums
  class Fuzziness

  # A unit class that encapsulates all in-exact search parsing and conversion from similarities to edit distances etc.

    AUTO = "AUTO"
    ZERO = 0
    ONE = 1
    TWO = 2

    attr_reader :fuzziness

  # Returns a fuzziness object with maximum levenshtein distance as one.
    def self.zero
      return self.new(ZERO)
    end

  # Returns a fuzziness object with maximum levenshtein distance as one.
    def self.one
      return self.new(ONE)
    end

  # Returns a fuzziness object with maximum levenshtein distance as two.
    def self.two
      return self.new(TWO)
    end

  # Returns a fuzziness object with maximum levenshtein distance in auto mode.
=begin
  Generates an edit distance based on the length of the term. Low and high distance arguments may be optionally provided 
  AUTO:[low],[high]. If not specified, the default values are 3 and 6, equivalent to AUTO:3,6 that make for lengths:
    0..2
      Must match exactly
    3..5
      One edit allowed
    >5
      Two edits allowed
  AUTO should generally be the preferred value for fuzziness.
=end
    def self.auto(low= nil, high= nil)
      return self.new("#{AUTO}:#{low},#{high}")
    end

    def initialize(fuzziness_value)
      @fuzziness = fuzziness_value
    end

  end
end



  
