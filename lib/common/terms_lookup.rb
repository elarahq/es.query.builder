class TermsLookup
=begin
  Terms lookup fetches the field values of an existing document
  Elasticsearch then uses those values as search terms. This can be helpful when searching for a large set of terms.
  Because terms lookup fetches values from a document, the _source mapping field must be enabled to use terms lookup. 
  The _source field is enabled by default.
=end

  attr_reader :index, :id, :path
  
  def initialize index, id, path
    @index = index
    @id = id
    @path = path
  end

  def settings
    settings = {}
    settings[:index] = @index.intern
    settings[:id] = @id.intern
    settings[:path] = @path.intern
    return settings
  end
  
end