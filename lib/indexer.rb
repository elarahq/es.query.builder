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
      raise "Not able to index with errors as #{(response["items"].map{|t| (t["index"] || t["update"])["error"]}.compact)}"
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
  # @param index_type [String] name of the type
  # @param id [String] doc_id
  # @param parent_id [String] parent_id
  def delete_record(index_name, type_name, id, parent_id = nil)
    if record_exists?(index_name, type_name, id, parent_id)
      @client.delete generate_options_hash(index_name, type_name, id, parent_id)
    end
  end

  # switches to new index ,will be used when doing bulk caching
  # @param new_index [String] name of the index(with timestamp)
  # @param alias name , name with which you refer to fetch index details
  # @param old_index_delete_flag, bool value to decide whether to keep last index or delete it
  def switch_to_new_index(new_index, alias_name, old_index_delete_flag = true)
    begin
      result = @client.indices.get_alias name: "#{alias_name}"
    rescue Exception => e
      puts "#{e.exception}"
      if e.class == Elasticsearch::Transport::Transport::Errors::NotFound
        result = nil
      else
        raise NameError,"#{e}"
      end
    end
    unless result.nil?
      if result.keys.count > 1
        raise NameError,"Multiple indexes found for alias #{alias_name}"
      else
        old_index = result.keys.first
        log_file = Logger.new("log/old_index.log")
        log_file.info("old_index - #{old_index}")
        @client.indices.update_aliases body: {
              actions: [
                { remove: { index: "#{old_index}", alias: "#{alias_name}" } },
                { add:    { index: "#{new_index}", alias: "#{alias_name}" } }
              ]
            }
        if old_index_delete_flag
            @client.indices.delete index: "#{old_index}"
        else
            @client.indices.close index: "#{old_index}"
        end
        message = old_index_delete_flag ? "index swapping done #{old_index} deleted and " : ""
        message += "#{new_index} created"
        puts message
      end
    else
      ## checks if index exists with the name of alias itself and handles accordingly.
      if @client.indices.exists(index: "#{alias_name}") && old_index_delete_flag
        @client.indices.delete index: "#{alias_name}"
        puts "#{alias_name} index deleted"
      end
      puts "Alias #{alias_name} set for new index #{new_index} "
      @client.indices.put_alias index: "#{new_index}", name: "#{alias_name}"
    end
    puts "#{new_index} set up"
  end

  # creates new index givem the mapping and settings in index_params_hash
  # @param index_name [String] name of the index(with timestamp)
  # @param index_type [String] name of the type
  # @param index_params_hash, {settins:{},mappings:{}}
  def create_index(index_name, index_type, index_params_hash)
    @client.indices.create index: "#{index_name}",
    type: "#{index_type}",
    body: index_params_hash
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