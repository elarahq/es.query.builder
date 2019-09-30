class MultiSearchRequest
  include AttributesReader

  def initialize
    @requests = []
  end

  def body
    return @requests.map{|request| {index: request.index, search: request.body}}
  end

# show requests
  def requests_expr
    return @requests
  end
# add requests
  def add request
    @requests.add(request)
    return self
  end

end