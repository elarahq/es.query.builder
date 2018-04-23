# used to index data in realtime to Elastic Search
require 'constants'
require 'exceptions/document_not_found_exception'

class Indexer
	
	# get elastic client
	def initialize(host, port)
		@client = Elasticsearch::Client.new(host: host, port: port)
	end


	# expects data in the form of
	# [
	# 	{ update: { _index: index2, _type: _doc, _id: 23, data: { doc: data } } },
	#		{ index: { _index: index2, _type: _doc, _id: 28, data: { doc: data } } }
	# ] 
	def bulk_index(data)
		check_bulk_index_params(data)
		response = @client.bulk body: data
		response = response.with_indifferent_access
		if response[:errors] == true
			raise "Not able to index with errors as #{(response["items"].map{|t| t["index"]["error"]}.compact)}"
		end
	end

	def record_exists?(index_name, type_name, id, parent_id = nil)
		options_hash = generate_options_hash(index_name, type_name, id, parent_id)
		@client.exists options_hash
	end

	def delete_record(index_name, type_name, id, parent_id = nil)
		if record_exists?(index_name, type_name, id, parent_id)
			@client.delete generate_options_hash(index_name, type_name, id, parent_id)
		else
			raise DocumentNotFoundException.new(index_name, type_name, id)
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
		raise "Record count should be less than #{Constants::MAX_BULK_INDEX_SIZE}" if Constants::MAX_BULK_INDEX_SIZE
	end

end