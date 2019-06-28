# The most simple query, which matches all documents
require_relative 'query_builder'
module Queries
  class MatchAllQueryBuilder < QueryBuilder

    NAME = 'match_all'

    def query
      query = {}
      matchall_query = self.common_query
      query[name.intern] = matchall_query
      return query
    end

  end
end