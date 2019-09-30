# frozen_string_literal: true

module Enums
  # Enumerator class for zer terms query.
  # If the analyzer used removes all tokens in a query like a stop filter does,
  # the default behavior is to match no documents at all.
  # In order to change that the zero_terms_query option can be used,
  # which accepts none (default) and all which corresponds to a match_all query.
  class ZeroTermsQuery
    # @!visibility protected
    attr_reader :zero_term
    # @!visibility protected
    ZERO_TERMS_QUERY = { all: 'all', none: 'none' }.freeze

    # @!visibility protected
    ZERO_TERMS_QUERY.each do |zero_term_query, es_value|
      define_singleton_method(zero_term_query) do
        return new(es_value)
      end
    end

    # @!scope class
    # @!method all
    # @return [ValidationMethods] ValidationMethods object
    #   corresponding to elasticsearch option of 'all'

    # @!scope class
    # @!method none
    # @return [ValidationMethods] ValidationMethods object
    #   corresponding to elasticsearch option of 'none'

    # @!visibility protected
    def initialize(zero_term)
      @zero_term = zero_term
    end
  end
end
