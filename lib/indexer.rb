# used to index data in almost realtime to Elastic Search

class Indexer
  
  # get elastic client object
  # @param host [String] Elastic Host
  # @param port [String] Elastic Port
  # @return [Indexer] to use indexing methods
  def initialize(host, port)
    @client = Elasticsearch::Client.new(host: host, port: port)
  end

  # expects data in the form of
  # [{update:{_index: index, _type: _doc, _id: 23, data: {doc: data }}},{index: {_index: index2, _type: _doc, _id: 28, data: data}}]
  # @param data [Array] Data to be indexed
  def bulk_index(data)
    check_bulk_index_params(data)
    response = @client.bulk body: data
    response = response.with_indifferent_access
    if response[:errors] == true
      raise "Not able to index with errors as #{(response["items"].map{|t| t["index"]["error"]}.compact)}"
    end
  end

  # checks whether the record exists in the given index with given type and id
  # @param index_name [String] name of the index
  # @param type_name_name [String] name of the type
  # @param id [String] doc_id
  # @param parent_id [String] parent_id (optional)
  # @return [True] if record found
  # @return [False] if record not found
  def record_exists?(index_name, type_name, id, parent_id = nil)
    options_hash = generate_options_hash(index_name, type_name, id, parent_id)
    @client.exists options_hash
  end

  # deletes the record if  exists in the given index with given type and id,
  # raises DocumentNotFoundException if record is not found
  # @param index_name [String] name of the index
  # @param index_name [String] name of the type
  # @param id [String] doc_id
  # @param parent_id [String] parent_id
  def delete_record(index_name, type_name, id, parent_id = nil)
    if record_exists?(index_name, type_name, id, parent_id)
      @client.delete generate_options_hash(index_name, type_name, id, parent_id)
    end
  end


  private

  def generate_options_hash(name, type, id, parent_id)
    options_hash = {
      index: name,
      type: type,
      id: id
    }
    options_hash[:parent] = parent_id if parent_id
    options_hash
  end

  def check_bulk_index_params(data)
    raise "Please provide and array of documents" unless data.is_a?(Array)
    count = data.size
    raise "Record count should be less than #{Constants::MAX_BULK_INDEX_SIZE}" if count > Constants::MAX_BULK_INDEX_SIZE
  end

end