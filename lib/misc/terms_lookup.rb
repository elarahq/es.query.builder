# frozen_string_literal: true

module Misc
  # Terms lookup fetches the field values of an existing document.
  # Elasticsearch then uses those values as search terms. This can be helpful
  # when searching for a large set of terms. Because terms lookup fetches values
  # from a document, the _source mapping field must be enabled to
  # use terms lookup. The _source field is enabled by default.
  class TermsLookup
    include AttributesReader

    # @params [String] index index name
    # @params [String] id document id
    # @params [String] path name of the field to fetch values from
    def initialize(index:, id:, path:)
      @index = index
      @id = id
      @path = path
    end

    # @return [Hash] serialized json query for the object
    def settings
      settings = {}
      settings[:index] = @index.intern
      settings[:id] = @id.intern
      settings[:path] = @path.intern
      settings
    end

    # @!visibility protected
    def index_expr
      @index
    end

    # @!visibility protected
    def id_expr
      @id
    end

    # @!visibility protected
    def path_expr
      @path
    end
  end
end
