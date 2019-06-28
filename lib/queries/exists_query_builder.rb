# Returns documents that contain a value other than null or [] in a provided field.
require_relative 'query_builder'
module Queries
  class ExistsQueryBuilder < QueryBuilder

    NAME = "exists"

    attr_reader :field_name

=begin
    @params:
      field_name: name of the field the existence of whose value is checked
=end
    def initialize field_name:
      @field_name= field_name
    end

    def query
      query = {}
      exists_query = self.common_query
      exists_query[:field] = @field_name
      query[name.intern] = exists_query
      return query
    end

  # returns field_name
    def field_name_expr
      return @field_name
    end
    
  end
end