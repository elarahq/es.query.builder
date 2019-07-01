# frozen_string_literal: true

require_relative 'abstract_query_builder'
require_relative '../attributes_reader'
module Queries
  # Base Class for all query classes
  #    QueryComponents
  #      boost: documents matching the query are boosted by
  #             the value
  class QueryBuilder
    include AbstractQueryBuilder
    include AttributesReader

    NAME = 'base'

    # @!visibility protected
    # @return [Numeric] the boost for this query
    def boost_expr
      @boost
    end

    # @param [Numeric]
    #   value boost value for the query
    # @return [QueryBuilder] modified self
    # sets the boost value for this query
    def boost(value)
      raise 'boost value is nil' if value.nil?

      @boost = value
      self
    end
  end
end
