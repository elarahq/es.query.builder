# having methods to fetch data from Elastic search
class FetchEsData

	# initializing elastic search host and port
	# @param search_host [String] Elastic Host
	# @param search_port [String] Elastic port
	# @return [FetchEsData] to perform search
	def initialize(search_host, search_port)
		@search_host = search_host
		@search_port = search_port
	end


	# fetches data from elastic search  
	# @param query [String] the input
	# @param index_name [String] name of the index
	# @param type_name [String] index type
	# @param extension [String] extension to Elastic seach path (eg. '_search', '_msearch')
	# @return [String, Hash]
	def fetch_shortlisted_data_from_es(query, index_name, type_name, extension = '_search')
		uri = URI("http://#{@search_host}:#{@search_port}/#{index_name}/#{type_name}/#{extension}")
		req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'application/json'})
		req.body = "#{query.to_json}\n"
		res = Net::HTTP.start(uri.hostname, uri.port) do |http|
			http.request(req)
		end
		body = JSON.parse(res.body) rescue {}
		return res.code, body
	end
end