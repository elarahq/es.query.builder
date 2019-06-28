require_relative 'abstract_query_builder'
require_relative '../attributes_reader'
module Queries
  class QueryBuilder
    include AbstractQueryBuilder
    include AttributesReader

    NAME = 'base'

  # returns the boost for this query
    def boost_expr
      return @boost
    end

  # sets the boost for this query
    def boost value
      raise "boost value is nil" if value.nil?
      @boost = value
      return self
    end

  end
end