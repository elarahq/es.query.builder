=begin
  Returns documents that contain one or more exact terms in a provided field.
  The terms query is the same as the term query, except you can search for multiple values.
=end
require_relative 'query_builder'
module Queries
  class TermsQueryBuilder < QueryBuilder

    NAME = "terms"
    
=begin 
    @params: 
      field_name: name of the field in the document which is being queried
      values: values which are matched to the data in that field can be:
                Data Set: 
                  Directly matched to the data in the given field.
                Terms Lookup:
                  Terms lookup fetches the field values of an existing document. 
                  Elasticsearch then uses those values as search terms. This can be helpful when searching for a large set of terms.
                  Because terms lookup fetches values from a document, the _source mapping field must be enabled to use terms lookup. 
                  The _source field is enabled by default.
=end
    def initialize field_name:, values: []
      @field_name = field_name
      if values.is_a?(Misc::TermsLookup)
        @terms_lookup = values
      else
        @values = values.is_a?(Array) ? values : values.split(',')
      end
    end

    def query
      query = {}
      terms_query = self.common_query
      terms_query[@field_name.intern] = @values
      terms_query[@field_name.intern] = @terms_lookup.settings if @terms_lookup.present?
      query[name.intern] = terms_query
      return query
    end

  ########## FIELD NAME ##########
  # returns field_name
    def field_name_expr
      return @field_name
    end

  ########## FIELD VALUE ##########
  # returns value
    def values_expr
      return @terms_lookup || @values
    end

  end
end