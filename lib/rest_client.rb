class RestClient

  def initialize host: '127.0.0.1', port: 9200
    @client = Elasticsearch::Client.new(host: host, port: port)
  end

  def search search_request
    return @client.search(index: search_request.attributes.index, body: search_request.body)
  end

  def msearch msearch_request
    return @client.msearch(body: msearch_request.body)
  end

  def index *args
    return @client.index(*args)
  end

  def bulk *args
    return @client.bulk(*args)
  end

  def create *args
    return @client.create(*args)
  end

  def delete *args
    return @client.delete(*args)
  end

  def delete_by_query *args
    args.first[:body] = SearchSourceBuilder.new.query(args.first[:body]).body
    return @client.delete_by_query(*args)
  end

  def get *args
    return @client.get(*args)
  end

  def mget *args
    return @client.mget(*args)
  end

  def update *args
    return @client.update(*args)
  end

  def update_by_query *args
    args.first[:body] = SearchSourceBuilder.new.query(args.first[:body]).body
    return @client.update_by_query(*args)
  end

end
