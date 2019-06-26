class ZeroTermsQuery

  attr_reader :zero_term

  ZERO_TERMS_QUERY = {all: "all", none: "none"}

  ZERO_TERMS_QUERY.each do |zero_term_query, es_value|
    define_singleton_method(zero_term_query) do
      return self.new(es_value)
    end
  end

  def initialize zero_term
    @zero_term = zero_term
  end

end