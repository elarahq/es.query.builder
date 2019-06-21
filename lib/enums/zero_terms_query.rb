class ZeroTermsQuery

  attr_reader :zero_terms

  ALL = "all"
  NONE = "none"

  def self.all
    return self.new(ALL)
  end

  def self.none
    return self.new(NONE)
  end

  def initialize value
    @zero_terms = value
  end

end