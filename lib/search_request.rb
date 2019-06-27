class SearchRequest
  include AttributesReader

  def initialize
    @index = ''
    @body = nil
  end

  def body
    return @source.body
  end

# returns index
  def index_expr
    return @index
  end
# sets index
  def index index
    @index= index
    return self
  end

# returns source
  def source_expr
    return @body
  end
# sets source
  def source source
    @source = source
    return self
  end 

end