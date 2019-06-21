class TermsLookup
  include AttributesReader
=begin
  Terms lookup fetches the field values of an existing document
  Elasticsearch then uses those values as search terms. This can be helpful when searching for a large set of terms.
  Because terms lookup fetches values from a document, the _source mapping field must be enabled to use terms lookup. 
  The _source field is enabled by default.
=end
  
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

  def index_expr
    return @index
  end

  def id_expr
    return @id
  end

  def path_expr
    return @path
  end
  
end